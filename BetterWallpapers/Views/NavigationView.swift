//
//  NavigationView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/20/23.
//

import SwiftUI

struct NavigationView: View {
    @Binding var currentTab: Tab
    
    var body: some View {
        HStack {
            Image("w.fill")
            
            Spacer()
            
            HStack {
                Button(action: { transitionTo(.wallpaper) }) {
                    Image(systemName: "square.3.layers.3d")
                }
                .buttonStyle(.plain)
                
                Button(action: { transitionTo(.favorites) }) {
                    Image(systemName: "bookmark")
                }
                .buttonStyle(.plain)
                
                Button(action: { transitionTo(.settings) }) {
                    Image(systemName: "gear")
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
        .zIndex(1)
    }
    
    private func transitionTo(_ tab: Tab) {
        withAnimation(.easeInOut) {
            currentTab = tab
        }
    }
}

struct NavigationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView(currentTab: .constant(.settings))
    }
}
