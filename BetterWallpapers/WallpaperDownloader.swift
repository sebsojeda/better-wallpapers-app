//
//  WallpaperDownloader.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/19/23.
//

import Foundation

class WallpaperDownloader: ObservableObject {
    @Published var isDownloading = false

    func downloadWallpaper(url: URL, completion: @escaping (URL?, Error?) -> Void) {
        isDownloading.toggle()
        
        do {
            let fileUrl = try FileManager.default.url(for: .cachesDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: false)
                .appendingPathComponent(url.lastPathComponent)
            
            if FileManager.default.fileExists(atPath: fileUrl.path()) {
                completion(fileUrl, nil)
                isDownloading.toggle()
                return
            }
            
            doDownload(url: url, toFile: fileUrl) { (error) in
                completion(fileUrl, error)
            }
        } catch {
            completion(nil, error)
        }
        
        isDownloading.toggle()
    }
    
    private func doDownload(url: URL, toFile file: URL, completion: @escaping (Error?) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) {
            (tempURL, response, error) in
            
            guard let tempURL = tempURL else {
                completion(error)
                return
            }

            do {
                try FileManager.default.copyItem(at: tempURL, to: file)
                completion(nil)
            }
            catch {
                completion(error)
            }
        }

        task.resume()
    }
}
