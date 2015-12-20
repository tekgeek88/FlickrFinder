//
//  CurrentDictionary.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/19/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation
import UIKit

struct CurrentDictionary {
    
    
    let dictionary: [String: AnyObject]?
    
    // This line serves as the entry point for a JSON Dictionary key.
    
    init(dictionaryObject: [String: AnyObject]) {
        if let incomingDictionary = dictionaryObject["photos"] as! [String: AnyObject]? {
            dictionary = incomingDictionary as [String: AnyObject]
            
          //  print(dictionary[0])
        }
        else {
            dictionary = nil
            print("Couldn't find key 'photos'!")
        }
        
    }
}
