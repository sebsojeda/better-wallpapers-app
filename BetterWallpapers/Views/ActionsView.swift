//
//  ActionsView.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/19/23.
//

import SwiftUI

struct ActionsView: View {
    @EnvironmentObject var controller: WallpaperController
        
    var body: some View {
        HStack {
            Button("Set Wallpaper", action: setWallpaper)
                .buttonStyle(.plain)
            
            Spacer()
            
            Button("Download", action: downloadWallpaper)
                .buttonStyle(.plain)
        }
        .padding()
    }
    
    func setWallpaper() {
        controller.setWallpaper()
    }
    
    func downloadWallpaper() {
        controller.downloadWallpaper()
    }
    
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView()
            .environmentObject(WallpaperController())
    }
}
