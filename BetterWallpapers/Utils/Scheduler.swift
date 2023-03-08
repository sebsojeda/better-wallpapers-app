//
//  Scheduler.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/25/23.
//

import Foundation

enum RefreshInterval: String, CaseIterable, Identifiable {
    case daily, weekly
    var id: Self { self }
}

class Scheduler {
    static private var timer: Timer = Timer()
    
    func schedule(interval: RefreshInterval, completion: @escaping () -> Void) {
        Scheduler.timer.invalidate()
        
        var timeInterval: TimeInterval
        switch (interval.id) {
        case .daily:
            timeInterval = TimeInterval(24 * 60 * 60)
            break
        case .weekly:
            timeInterval = TimeInterval(7 * 24 * 60 * 60)
            break
        }
        
        if let lastRunTimestamp = UserDefaults.standard.string(forKey: "lastRunTimestamp"),
           let timeIntervalSince1970 = TimeInterval(lastRunTimestamp) {
            
            let dateOfLastRun = Date(timeIntervalSince1970: timeIntervalSince1970)
            let timeIntervalSinceLastRun = Date().timeIntervalSince(dateOfLastRun)
            
            if timeIntervalSinceLastRun > timeInterval {
                completion()
                UserDefaults.standard.set(String(Date().timeIntervalSince1970), forKey: "lastRunTimestamp")
            } else {
                let nextRun = timeInterval - timeIntervalSinceLastRun
                Scheduler.timer = Timer.scheduledTimer(withTimeInterval: nextRun, repeats: false) { _ in
                    completion()
                    UserDefaults.standard.set(String(Date().timeIntervalSince1970), forKey: "lastRunTimestamp")
                    Scheduler.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
                        completion()
                        UserDefaults.standard.set(String(Date().timeIntervalSince1970), forKey: "lastRunTimestamp")
                    }
                }
                return
            }
        } else {
            completion()
            UserDefaults.standard.set(String(Date().timeIntervalSince1970), forKey: "lastRunTimestamp")
        }
        
        Scheduler.timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            completion()
            UserDefaults.standard.set(String(Date().timeIntervalSince1970), forKey: "lastRunTimestamp")
        }
    }
}
