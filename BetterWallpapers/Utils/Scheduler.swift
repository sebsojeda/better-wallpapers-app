//
//  Scheduler.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/25/23.
//

import Foundation
import Schedule

enum RefreshInterval: String, CaseIterable, Identifiable {
    case daily, weekly
    var id: Self { self }
}

class Scheduler {
    private var plan: Task?
    
    func schedule(interval: RefreshInterval, completion: @escaping () -> Void) {
        if plan != nil {
            plan!.cancel()
        }
        
        var timeInterval: Interval
        switch (interval.id) {
        case .daily:
            timeInterval = 1.days
            break
        case .weekly:
            timeInterval = 1.week
            break
        }
        
        if let lastRunTimestamp = getLastRunTimestamp(),
           let timeIntervalSince1970 = TimeInterval(lastRunTimestamp) {
            
            let dateOfLastRun = Date(timeIntervalSince1970: timeIntervalSince1970)
            let timeIntervalSinceLastRun = Date().timeIntervalSince(dateOfLastRun)
            
            if timeIntervalSinceLastRun > timeInterval.asSeconds() {
                completion()
                updateLastRunTimestamp()
            } else {
                let nextRun = (timeInterval.asSeconds() - timeIntervalSinceLastRun).seconds
                
                plan = Plan.after(nextRun, repeating: timeInterval).do {
                    completion()
                    self.updateLastRunTimestamp()
                }
                return
            }
        } else {
            completion()
            self.updateLastRunTimestamp()
        }
        
        plan = Plan.every(timeInterval).do {
            completion()
            self.updateLastRunTimestamp()
        }
    }
    
    func getLastRunTimestamp() -> String? {
        UserDefaults.standard.string(forKey: "lastRunTimestamp")
    }
    
    func updateLastRunTimestamp() {
        UserDefaults.standard.set(String(Date().timeIntervalSince1970), forKey: "lastRunTimestamp")
    }
}
