//
//  WallpaperManager.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/24/23.
//

import Foundation
import SwiftUI

class WallpaperManager {
    var fetcher: WallpaperFetcher
    var downloader: WallpaperDownloader
    var scheduler: WallpaperScheduler
    var settings: WallpaperSettings
    
    init(fetcher: WallpaperFetcher, downloader: WallpaperDownloader, scheduler: WallpaperScheduler, settings: WallpaperSettings) {
        self.fetcher = fetcher
        self.downloader = downloader
        self.scheduler = scheduler
        self.settings = settings
    }

    func scheduleRandomWallpaper(interval: RefreshInterval) {
        scheduler.scheduleActivity(interval: interval) {
            self.fetchRandomWallpaper()
        }
    }
    
    func scheduleRandomWallpaper() {
        scheduler.scheduleActivity(interval: settings.refreshInterval) {
            self.fetchRandomWallpaper()
        }
    }
    
    func fetchAndSetRandomWallpaper() {
        Task {
            try? await fetcher.fetchRandomWallpaper()
            setRandomWallpaper()
        }
    }
    
    func fetchRandomWallpaper() {
        Task {
            try? await fetcher.fetchRandomWallpaper()
        }
    }
    
    func setRandomWallpaper() {
        downloader.downloadWallpaper(url: fetcher.currentWallpaper.downloadUrl) {
            (url, error) in
            
            if error != nil {
                return
            }
            
            for screen in NSScreen.screens {
                try? NSWorkspace.shared.setDesktopImageURL(url!, for: screen)
            }
        }
    }
    
    func terminateApplication() {
        NSApplication.shared.terminate(self)
    }
}
