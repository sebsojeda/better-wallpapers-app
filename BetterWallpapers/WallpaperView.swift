//
//  Preview.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/17/23.
//

import SwiftUI

struct WallpaperView: View, Sendable {
    @EnvironmentObject var manager: WallpaperManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: manager.fetchRandomWallpaper) {
                WallpaperPreview(currentWallpaper: manager.fetcher.currentWallpaper)
                    .overlay {
                        if manager.fetcher.isFetching || manager.downloader.isDownloading {
                            ProgressView()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(5)
                        } else {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(5)
                        }
                    }
                    .overlay(alignment: .bottomLeading) {
                        if manager.fetcher.currentWallpaper.authorName != nil {
                            if manager.fetcher.currentWallpaper.authorUrl != nil {
                                Link("By \(manager.fetcher.currentWallpaper.authorName!)",
                                     destination: manager.fetcher.currentWallpaper.authorUrl!)
                                    .foregroundColor(Color.white)
                                    .padding()
                            } else {
                                Text("By \(manager.fetcher.currentWallpaper.authorName!)")
                                    .foregroundColor(Color.white)
                                    .padding()
                            }
                        }
                    }
            }
            .buttonStyle(.plain)
            .frame(height: 300)
            
            ActionsView()
        }
        .background(Color(.textBackgroundColor))
    }
    
}

struct WallpaperView_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperView()
            .environmentObject(WallpaperManager(fetcher: WallpaperFetcher(),
                                                downloader: WallpaperDownloader(),
                                                scheduler: WallpaperScheduler(),
                                                settings: WallpaperSettings()))
    }
}
