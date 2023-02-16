//
//  ContentView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/13/23.
//

import SwiftUI

enum Tab {
    case wallpaper, settings
}

struct ContentView: View {
    @State var currentTab: Tab = .wallpaper
    
    var body: some View {
        VStack(alignment: .leading) {
            NavigationView(currentTab: $currentTab)
            
            ZStack {
                if currentTab == .wallpaper {
                    WallpaperView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .top),
                            removal: .opacity.combined(with: .move(edge: .top))))
                }
                
                if currentTab == .settings {
                    SettingsView()
                        .transition(.asymmetric(
                            insertion: .move(edge: .bottom),
                            removal: .opacity.combined(with: .move(edge: .bottom))))
                }
            }
            
            Spacer()
        }
        .background(Color(.textBackgroundColor))
        .frame(width: 455, height: 420)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WallpaperController())
            .environmentObject(Settings())
    }
}
