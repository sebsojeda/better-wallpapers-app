//
//  LoadableImage.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/18/23.
//

import Foundation
import SwiftUI

struct WallpaperPreview: View {
    var currentWallpaper: Wallpaper
    
    var body: some View {
        AsyncImage(url: currentWallpaper.previewUrl) { image in
            image
                .resizable()
        } placeholder: {
            Image(blurHash: currentWallpaper.blurHash)!
                .resizable()
        }
        .id(currentWallpaper.id)
        .transition(.opacity.animation(.easeInOut))
    }
}

struct WallpaperPreview_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperPreview(currentWallpaper: Wallpaper.defaultWallpaper)
    }
}
