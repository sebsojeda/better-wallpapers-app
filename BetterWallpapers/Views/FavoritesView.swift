//
//  FavoritesView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 3/7/23.
//

import SwiftUI

struct FavoritesView: View {
    @Binding var currentTab: Tab
    @EnvironmentObject var favorites: Favorites
    @EnvironmentObject var controller: WallpaperController
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Favorites")
                .font(.headline)
                .padding([.horizontal])
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.fixed(135)), GridItem(.fixed(135)), GridItem(.fixed(135))]) {
                    ForEach(0..<favorites.favoriteWallpapers.count, id: \.self) { i in
                        Button(action: { transitionTo(favorites.favoriteWallpapers[i]) }) {
                            ImageView(currentWallpaper: favorites.favoriteWallpapers[i])
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 135, height: 90)
                                .clipped()
                        }
                        .frame(width: 135, height: 90)
                        .buttonStyle(.plain)
                        .cornerRadius(5)
                        .overlay(alignment: .topTrailing) {
                            Button(action: {favorites.unfavorite(favorites.favoriteWallpapers[i])}) {
                                Image(systemName: "xmark")
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 0, y: 1)
                                    .padding()
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    private func transitionTo(_ wallpaper: Wallpaper) {
        controller.currentWallpaper = wallpaper
        withAnimation(.easeInOut) {
            currentTab = .wallpaper
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(currentTab: .constant(.favorites))
            .environmentObject(Favorites())
            .environmentObject(WallpaperController())
    }
}
