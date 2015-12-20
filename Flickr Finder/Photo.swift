//
//  CurrentPhoto.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/19/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation


import UIKit

struct Photo {
    
    // All the variables that a current photo holds
    let id: String?
    let owner: String?
    let secret: String?
    let server: String?
    let farm: Int?
    let title: String?
    let isPublic: Int?
    let isFamily: Int?
    let url: String?
    
    
    // The init serves as the blueprint for creating the photo objecs
    init(currentPhotoDictionary: [String: AnyObject]) {
        id = currentPhotoDictionary["id"] as? String
        owner = currentPhotoDictionary["owner"] as? String
        secret = currentPhotoDictionary["secret"] as? String
        server = currentPhotoDictionary["server"] as? String
        farm = currentPhotoDictionary["farm"] as? Int
        title = currentPhotoDictionary["title"] as? String
        isPublic = currentPhotoDictionary["isPublic"] as? Int
        isFamily = currentPhotoDictionary["isFamily"] as? Int
        url = "https://farm\(farm!).staticflickr.com/\(server!)/\(id!)_\(secret!).jpg"
        
        
        // To request a photo URL
        // https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    }
}