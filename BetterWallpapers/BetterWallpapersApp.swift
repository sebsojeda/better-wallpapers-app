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
    
    var body: some Scene {
        MenuBarExtra("Better Wallpapers", systemImage: "bolt.square.fill") {
            ContentView()
                .environmentObject(controller)
                .environmentObject(settings)
                .onAppear {
                    controller.scheduleNextWallpaper(interval: settings.refreshInterval)
                }
        }
        .menuBarExtraStyle(.window)
    }
}
