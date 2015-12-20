//
//  CurrentWeather.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/17/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    
    let temperature: Int?
    
    // This line serves as the entry point for a JSON Dictionary key.

    init(weatherDictionary: [String: AnyObject]) {
        temperature = weatherDictionary["temperature"] as? Int
        }
}