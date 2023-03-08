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
    let previewUrl: URL
    let downloadUrl: URL
    
    static let defaultWallpaper = Wallpaper(id: 11,
                                            authorUrl: URL(string: "https://unsplash.com/@wonderwallphotos")!,
                                            authorName: "Zach Kessinger",
                                            blurHash: "LjJ8w_t7s:of%%ayE2js?Hj]fiax",
                                            externalId: "awvl2nzv1y5kvuhnndaw",
                                            previewUrl: URL(string: "https://res.cloudinary.com/better-wallpapers/image/upload/c_fill,q_100,w_600,h_400/awvl2nzv1y5kvuhnndaw.jpg")!,
                                            downloadUrl: URL(string: "https://res.cloudinary.com/better-wallpapers/image/upload/awvl2nzv1y5kvuhnndaw.jpg")!)
}
