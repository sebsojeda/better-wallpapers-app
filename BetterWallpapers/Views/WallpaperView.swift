//
//  WallpaperView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/17/23.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .opacity(1)
    }
}

struct WallpaperView: View, Sendable {
    @EnvironmentObject var controller: WallpaperController
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        VStack {
            Button(action: fetchRandomWallpaper) {
                ImageView(currentWallpaper: controller.currentWallpaper)
                    .overlay {
                        if controller.isLoading {
                            ProgressView()
                                .colorInvert()
                                .frame(width: 24, height: 24)
                                .padding(10)
                                .background(Color.black.opacity(0.5))
                                .cornerRadius(5)
                        } else {
                            Image(systemName: "arrow.clockwise")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(5)
                        }
                    }
                    .overlay(alignment: .bottomLeading) {
                        if controller.currentWallpaper.authorName != nil {
                            if controller.currentWallpaper.authorUrl != nil {
                                Link("By \(controller.currentWallpaper.authorName!)",
                                     destination: controller.currentWallpaper.authorUrl!)
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 3, x: 0, y: 3)
                                    .padding()
                            } else {
                                Text("By \(controller.currentWallpaper.authorName!)")
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                    }
                    .overlay(alignment: .bottomTrailing) {
                        if (favorites.favoriteWallpapers.contains(where: { wallpaper in
                            controller.currentWallpaper.id == wallpaper.id
                        })) {
                            Button(action: { favorites.unfavorite(controller.currentWallpaper) }) {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 0, y: 1)
                                    .padding()
                            }
                            .buttonStyle(.plain)
                        } else {
                            Button(action: { favorites.favorite(controller.currentWallpaper) }) {
                                Image(systemName: "heart")
                                    .foregroundColor(.white)
                                    .shadow(color: .black, radius: 1, x: 0, y: 1)
                                    .padding()
                            }
                            .buttonStyle(.plain)
                        }
                    }
            }
            .buttonStyle(CustomButtonStyle())
            .cornerRadius(5)
            .padding([.horizontal])
            .frame(height: 300)
            
            
            ActionsView()
        }
    }
    
    func fetchRandomWallpaper() {
        if !controller.isLoading {
            controller.fetchRandomWallpaper()
        }
    }
}

struct WallpaperView_Previews: PreviewProvider {
    static var previews: some View {
        WallpaperView()
            .environmentObject(WallpaperController())
            .environmentObject(Favorites())
    }
}
