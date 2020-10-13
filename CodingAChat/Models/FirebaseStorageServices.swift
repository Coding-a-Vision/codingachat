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
}
