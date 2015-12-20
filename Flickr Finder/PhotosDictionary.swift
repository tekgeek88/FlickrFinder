//
//  PhotosDictionary.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/19/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation


struct PhotosDictionary {
    
    let page: Int?
    let pages: Int?
    let perpage: Int?
    let total: Int?
    var photos: [Photo] = []
    
    init(photosDictionary: [String: AnyObject]?) {
        if let currentPhotosDictionary = photosDictionary?["photos"] as? [String: AnyObject] {
            page = currentPhotosDictionary["page"] as? Int
            pages = currentPhotosDictionary["pages"]as? Int
            perpage = currentPhotosDictionary["perpage"] as? Int
            if let totalString = currentPhotosDictionary["total"] as? String {
                total = Int(totalString)
            }
            else {
             total = nil
            }
        }
        else {
            print("Photos dictionary failed to load results")
            page = nil
            pages = nil
            perpage = nil
            total = nil
            
        }
        if let photoArray = photosDictionary?["photos"]?["photo"] as? [[String: AnyObject]] {
            
            for photo in photoArray {
                let p = Photo(currentPhotoDictionary: photo)
                    photos.append(p)
            }
            
        }

    }

                // temperature = weatherDictionary["temperature"] as? Int
                //CurrentWeather(weatherDictionary: currentWeatherDictionary)
        
        /*
        
        init(weatherDictionary: [String: AnyObject]?) {
            if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject] {
                currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        
        */
        // Now we need to traverse the JSON string for the "daily" key and then the "data" key
        // We have chained the result from the "data" key to the result of the "daily" key
        //if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]] {
        
        // for dailyWeather in weeklyWeatherArray {
        //     let daily = DailyWeather(dailyWeatherDict: dailyWeather)
        //     weekly.append(daily)
        //}
        
        //}
    

}
