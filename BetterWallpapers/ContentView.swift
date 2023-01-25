//
//  SwiftUIView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/13/23.
//

import SwiftUI
import UnifiedBlurHash

extension AnyTransition {
    static var moveInOut: AnyTransition {
        .asymmetric(
            insertion: .move(edge: .top),
            removal: .identity)
    }
}

struct ContentView: View {
    @State var currentTab: Tab = .wallpaper
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView(currentTab: $currentTab)
                .zIndex(3)
            
            if currentTab == .wallpaper {
                WallpaperView()
                    .zIndex(2)
                    .transition(.moveInOut)
            }
            
            if currentTab == .settings {
                SettingsView()
                    .zIndex(1)
                    .transition(.moveInOut)
            }
        }
        .background(Color(.textBackgroundColor))
        .frame(width: 450)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WallpaperManager(fetcher: WallpaperFetcher(),
                                                downloader: WallpaperDownloader(),
                                                scheduler: WallpaperScheduler(),
                                                settings: WallpaperSettings()))
    }
}
