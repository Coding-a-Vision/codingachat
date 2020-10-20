//
//  FirebaseStorageServices.swift
//  CodingAChat
//
//  Created by Claudio Barbera on 13/10/2020.
//  Copyright © 2020 CodingAVision. All rights reserved.
//

import Foundation
import PromiseKit
import FirebaseStorage

class FirebaseStorageServices {
    
    private let cache: Cacheable
    
    init(cache: Cacheable = KingfisherCacheServices()) {
        self.cache = cache
    }
    
    func uploadImage(_ imageData: Data, imageName: String) -> Promise<URL> {
        
        return Promise<URL> { seal in
            
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imageRef = storageRef.child(imageName)
            
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                
                if let metadata = metadata {
                    print("ok!!! \(metadata)")
                } else if let error = error {
                    seal.reject(error)
                }
                
                // You can also access to download URL after upload.
                imageRef.downloadURL { (url, error) in
                    
                    if let url = url {
                        seal.fulfill(url)
                    } else if let error = error {
                        seal.reject(error)
                    }
                }
            }
        }
    }
    
    func donwloadImage(_ name: String) -> Promise<UIImage> {
        
        return Promise<UIImage> { seal in
            
            if cache.isImageCached(for: name) {
                
                cache.getImage(for: name) { res, err in
                    
                    if let res = res {
                        seal.fulfill(res)
                    } else if let err = err {
                        seal.reject(err)
                    }
                }
            } else {
                let storage = Storage.storage()
                
                // Create a reference with an initial file path and name
                let pathReference = storage.reference(withPath: name)
                
                pathReference.getData(maxSize: 10 * 1024 * 1024) { [weak self] data, error in
                    if let error = error {
                        seal.reject(error)
                    } else if let data = data, let image = UIImage(data: data) {
                        seal.fulfill(image)
                        self?.cache.store(image: image, forKey: name)
                    }
                }
            }
        }
    }
}
