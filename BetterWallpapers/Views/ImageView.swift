//
//  ImageView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/18/23.
//

import Foundation
import SwiftUI
import UnifiedBlurHash
import URLImage

struct ImageView: View {
    var currentWallpaper: Wallpaper
    
    var body: some View {
        
        URLImage(currentWallpaper.previewUrl) {
            EmptyView()
        } inProgress: { progress in
            Image(blurHash: currentWallpaper.blurHash)!
                .resizable()
        } failure: { error, retry in
            EmptyView()
        } content: { image in
            image
                .resizable()
        }
        .id(currentWallpaper.id)
        .transition(.opacity.animation(.easeInOut))
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(currentWallpaper: Wallpaper.defaultWallpaper)
    }
}
