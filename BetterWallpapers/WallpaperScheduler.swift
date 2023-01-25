//
//  WallpaperScheduler.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/25/23.
//

import Foundation

enum RefreshInterval: String, CaseIterable, Identifiable {
    case hourly, daily, weekly
    var id: Self { self }
}

class WallpaperScheduler {
    private let activity = NSBackgroundActivityScheduler(identifier: "app.betterwallpapers.BetterWallpapers.scheduledActivity")
    
    func scheduleActivity(interval: RefreshInterval, callback: @escaping () -> Void) {
        print("Scheduling a wallpaper refresh to be: \(interval)")
        activity.invalidate()
        activity.repeats = true
        
        switch (interval.id) {
        case .hourly:
            activity.interval = 60 * 60
            break
        case .daily:
            activity.interval = 24 * 60 * 60
            break
        case .weekly:
            activity.interval = 7 * 24 * 60 * 60
            break
        }
        
        activity.interval = 10
        
        activity.schedule() { completion in
            callback()
            completion(.finished)
        }
    }
}
