//
//  Favorites.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 3/7/23.
//

import Foundation
import SwiftUI

class Favorites: ObservableObject {
    @AppStorage("favoriteWallpapers") var favoriteWallpapers: [Wallpaper] = [Wallpaper.defaultWallpaper]
    
    func favorite(_ wallpaper: Wallpaper) {
        favoriteWallpapers.append(wallpaper)
    }
    
    func unfavorite(_ wallpaper: Wallpaper) {
        for (i, favoriteWallpaper) in favoriteWallpapers.enumerated() {
            if (favoriteWallpaper.id == wallpaper.id) {
                favoriteWallpapers.remove(at: i)
                break
            }
        }
    }
}
