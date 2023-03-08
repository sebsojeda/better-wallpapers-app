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
            let supportDirectory = try FileManager.default.url(for: .applicationSupportDirectory,
                                                               in: .userDomainMask,
                                                               appropriateFor: nil,
                                                               create: false)
                .appendingPathComponent(Bundle.main.bundleIdentifier!)
            
            if !FileManager.default.fileExists(atPath: supportDirectory.path) {
                do {
                    try FileManager.default.createDirectory(atPath: supportDirectory.path,
                                                            withIntermediateDirectories: true)
                } catch {
                    // TODO: log error
                    completion(nil, error)
                    return
                }
            }
            
            let fileUrl = supportDirectory.appendingPathComponent(url.lastPathComponent)
            
            if FileManager.default.fileExists(atPath: fileUrl.path) {
                completion(fileUrl, nil)
                return
            } else {
                do {
                    let filePaths = try FileManager.default.contentsOfDirectory(atPath: supportDirectory.path)
                    for filePath in filePaths {
                        try FileManager.default.removeItem(atPath: supportDirectory.appendingPathComponent(filePath).path)
                    }
                } catch {
                    // TODO: log warning
                }
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
