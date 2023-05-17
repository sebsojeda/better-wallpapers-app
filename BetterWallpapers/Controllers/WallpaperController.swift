//
//  WallpaperController.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/26/23.
//

import Foundation
import SwiftUI

class WallpaperController: ObservableObject {
    private let downloader = Downloader()
    private let fetcher = Fetcher()
    private let scheduler = Scheduler()
    
    private var endpoint: URLComponents
    
    @Published var currentWallpaper: Wallpaper
    @Published var isLoading: Bool
    
    init() {
        self.endpoint = URLComponents(string: "https://www.betterwallpapers.app/api/random")!
        if let currentWallpaper = UserDefaults.standard.string(forKey: "currentWallpaper")?.data(using: .utf8) {
            self.currentWallpaper = try! JSONDecoder().decode(Wallpaper.self, from: currentWallpaper)
        } else {
            self.currentWallpaper = Wallpaper.defaultWallpaper
        }
        self.isLoading = false
    }
    
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
        
        fetcher.fetch(Wallpaper.self, endpoint: endpoint.url!.absoluteString) { wallpaper, error in
            if error != nil {
                // TODO: log error
                Task { @MainActor in
                    self.isLoading.toggle()
                }
                return
            }
            
            Task { @MainActor in
                self.currentWallpaper = wallpaper!
                if let data = try? JSONEncoder().encode(wallpaper) {
                    UserDefaults.standard.set(String(data: data, encoding: .utf8), forKey: "currentWallpaper")
                }
                self.isLoading.toggle()
            }
        }
    }

    func setWallpaper() {
        isLoading.toggle()
        
        scheduler.updateLastRunTimestamp()
        
        downloader.download(url: currentWallpaper.downloadUrl) { file, error in
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
    
    func downloadWallpaper() {
        isLoading.toggle()
        
        downloader.download(url: currentWallpaper.downloadUrl) { file, error in
            if error != nil {
                // TODO: log error
                Task { @MainActor in
                    self.isLoading.toggle()
                }
                return
            }
            
            do {
                let downloadsDirectory = try FileManager.default.url(for: .downloadsDirectory,
                                                                     in: .userDomainMask,
                                                                     appropriateFor: nil,
                                                                     create: false)
                
                let downloadUrl = downloadsDirectory.appendingPathComponent(file!.lastPathComponent)
                
                if !FileManager.default.fileExists(atPath: downloadUrl.path) {
                    try FileManager.default.copyItem(at: file!, to: downloadUrl)
                }
                
                Task { @MainActor in
                    self.isLoading.toggle()
                }
            } catch {
                Task { @MainActor in
                    self.isLoading.toggle()
                }
            }
        }
    }

    
    func scheduleNextWallpaper(interval: RefreshInterval) {
        scheduler.schedule(interval: interval) {
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
            
            self.fetcher.fetch(Wallpaper.self, endpoint: self.endpoint.url!.absoluteString) {
                wallpaper, error in
                
                if error != nil {
                    // TODO: log error
                    Task { @MainActor in
                        self.isLoading.toggle()
                    }
                    return
                }
                
                self.downloader.download(url: wallpaper!.downloadUrl) { file, error in
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
                        if let data = try? JSONEncoder().encode(wallpaper) {
                            UserDefaults.standard.set(String(data: data, encoding: .utf8), forKey: "currentWallpaper")
                        }
                        self.isLoading.toggle()
                    }
                }
            }
        }
    }
}
