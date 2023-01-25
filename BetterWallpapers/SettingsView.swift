//
//  SettingsView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/20/23.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var manager: WallpaperManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Schedule", selection: manager.settings.$refreshInterval) {
                ForEach (RefreshInterval.allCases) { interval in
                    Text(interval.rawValue.capitalized).tag(interval)
                }
            }
            .onChange(of: manager.settings.refreshInterval) { interval in
                manager.scheduleRandomWallpaper(interval: interval.id)
            }
            .frame(width: 150)
            .padding()
        }
        .background(Color(.textBackgroundColor))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(WallpaperManager(fetcher: WallpaperFetcher(),
                                                downloader: WallpaperDownloader(),
                                                scheduler: WallpaperScheduler(),
                                                settings: WallpaperSettings()))
    }
}
