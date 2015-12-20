//
//  FlickrService.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/19/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation

struct FlickrService {
    
    let APIString: String
    //let flickrBaseURL: NSURL?
    
    init (FlickerAPIKey: String) {
    
        self.APIString = FlickerAPIKey
        //self.flickrBaseURL = ""
    }
    
    
    func getDictionaryObject (completion: PhotosDictionary? -> Void) {
        if let getRequest = NSURL(string: APIString) {
            
            // Create an instance of the NetworkOperation class and pass in the URL
            let networkOperation = NetworkOperation(url: getRequest)
            
            // Download the JSON object and send it to the PhotosDictionary for parsing
            networkOperation.downloadJSONFromURL{
                (let JSONDictionary) in
               // let currentDictionary = JSONDictionary
                //completion(currentDictionary)
            
            
                let currentPhotosDictionary = PhotosDictionary(photosDictionary: JSONDictionary)
                completion(currentPhotosDictionary)

            }// End networkOperation.downloadJSONFromURL
        }
        else {
            "Could not construct a vailid NSURL object"
        }
    }
    
    func retrieveCurrentDictionary(jsonDictionary: [String: AnyObject]?) -> CurrentDictionary? {
        if let currentDictionary = jsonDictionary! as [String: AnyObject]? {
            return CurrentDictionary(dictionaryObject: currentDictionary)
        }
        else {
            print("JSON dictionary returned nil")
            return nil
        }
    }
}


