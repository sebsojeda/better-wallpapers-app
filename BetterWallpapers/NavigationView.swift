//
//  NavigationView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/20/23.
//

import SwiftUI

enum Tab {
    case wallpaper, settings
}

struct NavigationView: View {
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack {
            Text("Better Wallpapers")
            
            Spacer()
            
            HStack {
                Button(action: { transitionTo(.wallpaper) }) {
                    Image(systemName: "square.3.layers.3d")
                }
                .buttonStyle(.plain)
                
                Button(action: { transitionTo(.settings) }) {
                    Image(systemName: "gear")
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .background(Color(.textBackgroundColor))
        .transaction { transaction in transaction.animation = nil }
    }
    
    private func transitionTo(_ tab: Tab) {
        withAnimation {
            currentTab = tab
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(currentTab: .constant(.wallpaper))
    }
}
