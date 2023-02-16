//
//  Downloader.swift
//  BetterWallpapers
//
//  Created by Sebastian Ojeda on 1/25/23.
//

import Foundation

class Downloader {    
    func download(url: URL, completion: @escaping (URL?, Error?) -> Void) {
        do {
            let fileUrl = try FileManager.default.url(for: .cachesDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: false)
                .appendingPathComponent(url.lastPathComponent)
            
            if FileManager.default.fileExists(atPath: fileUrl.path()) {
                completion(fileUrl, nil)
                return
            }
            
            let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
                guard let tempURL = tempURL else {
                    completion(nil, error)
                    return
                }

                do {
                    try FileManager.default.copyItem(at: tempURL, to: fileUrl)
                    completion(fileUrl, nil)
                }
                catch {
                    completion(nil, error)
                    return
                }
            }

            task.resume()
        } catch {
            completion(nil, error)
        }
    }
}
