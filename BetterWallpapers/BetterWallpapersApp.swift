//
//  BetterWallpapersApp.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/13/23.
//

import SwiftUI

@main
struct BetterWallpapersApp: App {
    @StateObject var fetcher = WallpaperFetcher()
    @StateObject var downloader = WallpaperDownloader()
    @StateObject var settings = WallpaperSettings()
    var manager = WallpaperManager(fetcher: WallpaperFetcher(), downloader: WallpaperDownloader(), scheduler: WallpaperScheduler(), settings: WallpaperSettings())
    
    init() {
        manager.scheduleRandomWallpaper()
    }
    
    var body: some Scene {
        MenuBarExtra("Better Wallpapers", systemImage: "bolt.square.fill") {
            ContentView()
                .environmentObject(fetcher)
                .environmentObject(downloader)
                .environmentObject(settings)
        }
        .menuBarExtraStyle(.window)
    }
}
