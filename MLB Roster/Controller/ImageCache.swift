//
//  ImageCache.swift
//  MLB Roster
//
//  Created by Alec O'Connor on 3/6/18.
//  Copyright © 2018 Alec O'Connor. All rights reserved.
//

import UIKit

class ImageCache {
    
    // Singleton for quick shared access
    // Singletons are not the best method for dependencies, but I used it here because of limited time
    static let shared = ImageCache()
    private init() {  }
    
    let cache = NSCache<NSString, UIImage>()
    let session = URLSession.shared
    
    func getImage(fromURL url: URL, completion: @escaping ((UIImage?, URL)->())) {
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            // Return the cached image in the completion handler
            completion(image, url)
        } else {
            // The image needs to be requested from the network
            DispatchQueue.global(qos: .userInteractive).async {
                do {
                    let imageData = try Data(contentsOf: url)
                    if let image = UIImage(data: imageData) {
                        // Successful download, save it and return the image in the completion handler
                        self.cache.setObject(image, forKey: url.absoluteString as NSString)
                        completion(image, url)
                    } else {
                        completion(nil, url)
                    }
                } catch {
                    completion(nil, url)
                }
            }
        }
        
    }
    
}

