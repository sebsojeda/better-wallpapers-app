//
//  WallpaperSettings.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/24/23.
//

import Foundation
import SwiftUI

class WallpaperSettings: ObservableObject {
    @AppStorage("refreshInterval") var refreshInterval: RefreshInterval = .daily
}
