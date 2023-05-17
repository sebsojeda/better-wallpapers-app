//
//  BetterWallpapersApp.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/13/23.
//

import SwiftUI

@main
struct BetterWallpapersApp: App {
    @StateObject var controller = WallpaperController()
    @StateObject var settings = Settings()
    @StateObject var favorites = Favorites()
    
    init() {
    }
    
    var body: some Scene {        
        MenuBarExtra("Better Wallpapers", image: "w.fill") {
            ContentView()
                .environmentObject(controller)
                .environmentObject(settings)
                .environmentObject(favorites)
                .onAppear {
                    controller.scheduleNextWallpaper(interval: settings.refreshInterval)
                }
        }
        .menuBarExtraStyle(.window)
    }
}
