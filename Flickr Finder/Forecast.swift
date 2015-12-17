//
//  Forecast.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/17/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation

struct Forecast {
    
    var currentWeather: CurrentWeather?
    //var weekly: [DailyWeather] = []
    
    init(weatherDictionary: [String: AnyObject]?) {
        if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject] {
            currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
        }
        // Now we need to traverse the JSON string for the "daily" key and then the "data" key
        // We have chained the result from the "data" key to the result of the "daily" key
        //if let weeklyWeatherArray = weatherDictionary?["daily"]?["data"] as? [[String: AnyObject]] {
            
           // for dailyWeather in weeklyWeatherArray {
           //     let daily = DailyWeather(dailyWeatherDict: dailyWeather)
           //     weekly.append(daily)
            //}
            
        //}
        
    }
    
}
