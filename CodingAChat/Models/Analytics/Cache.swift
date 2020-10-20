//
//  Cache.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 20/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation
import Kingfisher

protocol Cacheable {
    func isImageCached(for key: String) -> Bool
    func getImage(for key: String, completion: @escaping (UIImage?, Error?) -> Void)
    func store(image: UIImage, forKey key: String)
}

class KingfisherCacheServices: Cacheable {
    
    func isImageCached(for key: String) -> Bool {
        return KingfisherManager.shared.cache.isCached(forKey: key)
    }
    
    func getImage(for key: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        KingfisherManager.shared.cache.retrieveImage(forKey: key) { res in
            switch res {
            case .success(let image):
                if let image = image.image {
                    completion(image, nil)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func store(image: UIImage, forKey key: String) {
        KingfisherManager.shared.cache.store(image, forKey: key)
    }
}
