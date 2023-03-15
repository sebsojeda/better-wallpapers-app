//
//  Settings.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/24/23.
//

import Foundation
import SwiftUI

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct Tag: Codable {
    var title: String
    var image: String
    var checked: Bool
}

class Settings: ObservableObject {
    @AppStorage("refreshInterval") var refreshInterval: RefreshInterval = .daily
    @AppStorage("updateAllScreens") var updateAllScreens: Bool = true
    @AppStorage("tags") var tags: [Tag] = [
        Tag(title: "Editorial", image: "editorial", checked: true),
        Tag(title: "Nature", image: "nature", checked: true),
        Tag(title: "Space", image: "space", checked: true),
        Tag(title: "Abstract", image: "abstract", checked: true),
        Tag(title: "Patterns", image: "patterns", checked: true),
        Tag(title: "Sports", image: "sports", checked: true),
        Tag(title: "Quotes", image: "quotes", checked: true),
        Tag(title: "Animals", image: "animals", checked: true),
        Tag(title: "Graphics", image: "graphics", checked: true),
        Tag(title: "Travel", image: "travel", checked: true),
        Tag(title: "Architecture", image: "architecture", checked: true),
        Tag(title: "Black and White", image: "blackandwhite", checked: true)
    ]
}
