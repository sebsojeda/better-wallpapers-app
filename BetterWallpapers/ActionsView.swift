//
//  ActionsView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/19/23.
//

import SwiftUI

struct ActionsView: View {
    @EnvironmentObject var manager: WallpaperManager
        
    var body: some View {
        HStack {
            Button("Set Wallpaper", action: manager.setRandomWallpaper)
                .buttonStyle(.plain)
            
            Spacer()
            
            Button("Quit", action: manager.terminateApplication)
                .buttonStyle(.plain)
        }
        .padding()
    }
    
    
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
            .environmentObject(WallpaperManager(fetcher: WallpaperFetcher(),
                                                downloader: WallpaperDownloader(),
                                                scheduler: WallpaperScheduler(),
                                                settings: WallpaperSettings()))
    }
}
