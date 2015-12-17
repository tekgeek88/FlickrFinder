//
//  ViewController.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/17/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    //////////////////////////////////////////////////////
    //     THE OUTLETS ASSOCIATED WITH THE VIEW ITEMS
    /////////////////////////////////////////////////////
    @IBOutlet weak var photoSummary: UILabel?
    
    
    
    
    
    //////////////////////////////////////////////////////
    //              API FETCHING STUFF
    /////////////////////////////////////////////////////
    private let forecastAPIKey = "5f159228b11e59e1f95bcef15e1d1283"
    let coordinate:(lat: Double, long: Double) = (37.8267,-122.423)
    
    /////////////////////////////////////////////////////
    //             Flickr Constants
    /////////////////////////////////////////////////////
    /* 1 - Define constants */
    let BASE_URL = "https://api.flickr.com/services/rest/"
    let METHOD_NAME = "flickr.galleries.getPhotos"
    let API_KEY = "ae369b9f4b35030234a9de1c3567d2cc"
    let GALLERY_ID = "5704-72157622566655097"
    let EXTRAS = "url_m"
    let DATA_FORMAT = "json"
    let NO_JSON_CALLBACK = "1"


    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        retrieveWeatherForecast()

        
    }
    
    
    func configureView() {
        print("configureView Ran!")
        retrieveWeatherForecast()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: - Weather Fetching
    
    func retrieveWeatherForecast() {
        print("A forecast was requested!")
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long) {
            (let forecast) in
            if let weatherForecast = forecast,
                let currentWeather = weatherForecast.currentWeather {
                    // Update UI
                    dispatch_async(dispatch_get_main_queue()) {
                        // execute closure
                        // This executes the task on the main thread and updates the labels and fields
                        
                        if let temperature = currentWeather.temperature{
                            self.photoSummary?.text = "\(temperature)º"
                        }
                        
                    }
            }
        }
        
        
        
        
        
    }// End of retrieve retrieveWeatherForecast()
    
    
    
}

