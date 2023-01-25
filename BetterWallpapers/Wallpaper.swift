//
//  Wallpaper.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/17/23.
//

import Foundation

struct Wallpaper: Identifiable, Codable {
    let id: Int
    let authorUrl: URL?
    let authorName: String?
    let blurHash: String
    let externalId: String
    let externalVersion: String
    let previewUrl: URL
    let downloadUrl: URL
    
    static let defaultWallpaper = Wallpaper(id: 1,
                                            authorUrl: nil,
                                            authorName: "Pramod Tiwari",
                                            blurHash: "LmGt]hozVrof.TkCWVbHjbjFtRf5",
                                            externalId: "pouMw93JWbEs",
                                            externalVersion: "v1673816521",
                                            previewUrl: URL(string: "https://res.cloudinary.com/better-wallpapers/image/upload/t_preview/v1673816521/pouMw93JWbEs.jpg")!,
                                            downloadUrl: URL(string: "https://res.cloudinary.com/better-wallpapers/image/upload/v1673816521/pouMw93JWbEs.jpg")!)
}
