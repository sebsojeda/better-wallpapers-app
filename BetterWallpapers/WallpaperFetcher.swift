//
//  WallpaperFetcher.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/18/23.
//

import Foundation
import SwiftUI

class WallpaperFetcher: ObservableObject {
    @Published var currentWallpaper = Wallpaper.defaultWallpaper
    @Published var isFetching = false
    
    let endpoint = "https://better-wallpapers-git-dev-sebsojeda.vercel.app/api/random?tag=editorial"
    
    enum FetchError: Error {
        case badRequest
        case badJSON
    }
    
    func fetchRandomWallpaper() async throws {
        toggleFetching()
        
        guard let url = URL(string: endpoint) else {
            toggleFetching()
            return
        }
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            toggleFetching()
            throw FetchError.badRequest
        }
        
        Task { @MainActor in
            currentWallpaper = try JSONDecoder().decode(Wallpaper.self, from: data)
        }
        toggleFetching()
    }
    
    private func toggleFetching() {
        Task { @MainActor in
            isFetching.toggle()
        }
    }
}
