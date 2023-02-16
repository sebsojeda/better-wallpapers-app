//
//  WallpaperView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/17/23.
//

import SwiftUI

struct WallpaperView: View, Sendable {
    @EnvironmentObject var controller: WallpaperController
    
    var body: some View {
        VStack {
            Button(action: fetchRandomWallpaper) {
                ImageView(currentWallpaper: controller.currentWallpaper)
                    .overlay {
                        if controller.isLoading {
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
                        if controller.currentWallpaper.authorName != nil {
                            if controller.currentWallpaper.authorUrl != nil {
                                Link("By \(controller.currentWallpaper.authorName!)",
                                     destination: controller.currentWallpaper.authorUrl!)
                                    .foregroundColor(.white)
                                    .padding()
                            } else {
                                Text("By \(controller.currentWallpaper.authorName!)")
                                    .foregroundColor(.white)
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
    }
}
