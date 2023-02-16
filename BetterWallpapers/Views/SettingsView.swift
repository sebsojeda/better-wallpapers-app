//
//  SettingsView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/20/23.
//

import Foundation
import SwiftUI
import LaunchAtLogin

struct SettingsView: View {
    @EnvironmentObject var controller: WallpaperController
    @EnvironmentObject var settings: Settings
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                LaunchAtLogin.Toggle()
                
                Toggle("Update on all screens", isOn: $settings.updateAllScreens)
                    .padding(.vertical)
                
                Picker("Schedule", selection: $settings.refreshInterval) {
                    ForEach (RefreshInterval.allCases) { interval in
                        Text(interval.rawValue.capitalized).tag(interval)
                    }
                }
                .onChange(of: settings.refreshInterval) { interval in
                    controller.scheduleNextWallpaper(interval: interval.id)
                }
                .frame(width: 150)
            }
            .padding(.horizontal)
            
            TagsView()
        }
        .background(Color(.textBackgroundColor))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(WallpaperController())
            .environmentObject(Settings())
    }
}
