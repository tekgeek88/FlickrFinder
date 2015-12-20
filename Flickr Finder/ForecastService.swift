//
//  ForecastService.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/17/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation


// This struct is used to handle the information need to put together the URI request
struct ForecastService {
    
    // The initializer requires you pass in an APIKey
    let forecastAPIKey: String
    let forecastBaseUrl: NSURL?
    init(APIKey: String) {
        forecastAPIKey = APIKey
        forecastBaseUrl = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    
    // This class request takes a lattitude and longitude parameter and then uses an instance of the Forecast class as
    // a completion handler to make the network request
    func getForecast(lat: Double, long: Double, completion: (Forecast? -> Void)) {
        
        // If let checks to see if URL is valid
        // This line creates the forecast query URL
        if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseUrl) {
            
            // Now that we have a url ready to go we create in instance of the NetworkOperation class and pass in the URL
            // It looks like we are using a closure statment to capture the JSON string and pass it to the Forecast class
            // so that it can be parsed
            let networkOperation = NetworkOperation(url: forecastURL)
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                // Parse the contents of the dictionary
                
                // print the whole JSON object
                
                let forecast = Forecast(weatherDictionary: JSONDictionary)
                completion(forecast)
                
            }
        }
        else {
            print("Could not construct valid URL")
        }
        
        
        // Assign it to a constant
    }// End of getForecast()
    
}
