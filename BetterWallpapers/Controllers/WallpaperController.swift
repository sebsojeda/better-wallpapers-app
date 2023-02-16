//
//  WallpaperController.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/26/23.
//

import Foundation
import SwiftUI

class WallpaperController: ObservableObject {
    private var endpoint = URLComponents(string: "https://www.betterwallpapers.app/api/random")!
    
    @Published var currentWallpaper = Wallpaper.defaultWallpaper
    @Published var isLoading = false
    
    func fetchRandomWallpaper() {
        isLoading.toggle()
    
        var tags: [Tag]
        if let data = UserDefaults.standard.string(forKey: "tags")?.data(using: .utf8) {
            tags = try! JSONDecoder().decode([Tag].self, from: data)
        } else {
            tags = Settings().tags
        }
        
        var queryItems: [URLQueryItem] = []
        for tag in tags {
            if tag.checked {
                queryItems.append(URLQueryItem(name: "tag", value: tag.title.lowercased()))
            }
        }
        endpoint.queryItems = queryItems
        
        Fetcher().fetch(Wallpaper.self, endpoint: endpoint.url!.absoluteString) { wallpaper, error in
            if error != nil {
                // TODO: log error
                Task { @MainActor in
                    self.isLoading.toggle()
                }
                return
            }
            
            Task { @MainActor in
                self.currentWallpaper = wallpaper!
                self.isLoading.toggle()
            }
        }
    }

    func downloadWallpaper() {
        isLoading.toggle()
        
        Downloader().download(url: currentWallpaper.downloadUrl) { file, error in
            if error != nil {
                // TODO: log error
                Task { @MainActor in
                    self.isLoading.toggle()
                }
                return
            }
            
            if UserDefaults.standard.bool(forKey: "updateAllScreens") {
                for screen in NSScreen.screens {
                    do {
                        try NSWorkspace.shared.setDesktopImageURL(file!, for: screen)
                    } catch {
                        // TODO: log error
                    }
                }
            } else {
                guard let screen = NSScreen.main else {
                    Task { @MainActor in
                        self.isLoading.toggle()
                    }
                    // TODO: log error
                    return
                }
                do {
                    try NSWorkspace.shared.setDesktopImageURL(file!, for: screen)
                } catch {
                    // TODO: log error
                }
            }
            
            Task { @MainActor in
                self.isLoading.toggle()
            }
        }
    }
    
    func scheduleNextWallpaper(interval: RefreshInterval) {
        Scheduler().schedule(interval: interval) {
            Task { @MainActor in
                self.isLoading.toggle()
            }
            
            var tags: [Tag]
            if let data = UserDefaults.standard.string(forKey: "tags")?.data(using: .utf8) {
                tags = try! JSONDecoder().decode([Tag].self, from: data)
            } else {
                tags = Settings().tags
            }
            
            var queryItems: [URLQueryItem] = []
            for tag in tags {
                if tag.checked {
                    queryItems.append(URLQueryItem(name: "tag", value: tag.title.lowercased()))
                }
            }
            self.endpoint.queryItems = queryItems
            
            Fetcher().fetch(Wallpaper.self, endpoint: self.endpoint.url!.absoluteString) {
                wallpaper, error in
                
                if error != nil {
                    // TODO: log error
                    Task { @MainActor in
                        self.isLoading.toggle()
                    }
                    return
                }
                
                Downloader().download(url: wallpaper!.downloadUrl) { file, error in
                    if error != nil {
                        // TODO: log error
                        Task { @MainActor in
                            self.isLoading.toggle()
                        }
                        return
                    }
                    
                    if UserDefaults.standard.bool(forKey: "updateAllScreens") {
                        for screen in NSScreen.screens {
                            do {
                                try NSWorkspace.shared.setDesktopImageURL(file!, for: screen)
                            } catch {
                                // TODO: log error
                            }
                        }
                    } else {
                        guard let screen = NSScreen.main else {
                            Task { @MainActor in
                                self.isLoading.toggle()
                            }
                            // TODO: log error
                            return
                        }
                        do {
                            try NSWorkspace.shared.setDesktopImageURL(file!, for: screen)
                        } catch {
                            // TODO: log error
                        }
                    }
                    
                    Task { @MainActor in
                        self.currentWallpaper = wallpaper!
                        self.isLoading.toggle()
                    }
                }
            }
        }
    }
}
