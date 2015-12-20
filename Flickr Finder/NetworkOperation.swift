//
//  NetworkOperation.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/17/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import Foundation

class NetworkOperation {
    
    lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration: self.config)
    let queryURL: NSURL
    typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> Void
    
    init(url: NSURL) {
        self.queryURL = url
    }
    
    func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
        
        let request: NSURLRequest = NSURLRequest(URL: queryURL)
        let dataTask = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            
            // 1. Check HTTP response for successfull GET request
            
            /* First we cast the response to an HTTP response so that we can access the property fields with the actual http response codes*/
            if let httpResponse = response as? NSHTTPURLResponse {
                
                // Since the response code comes back as an Integer this is a great place to add all of the cases that can cbe returned back from the HTTP server
                switch(httpResponse.statusCode) {
                case 200:
                    
                    // 2. Create JSON object with the returned data
                    do {
                        let JSONDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [String: AnyObject]
                        completion(JSONDictionary)
                    }
                    catch {
                        print(error)
                    }
                    
                default:
                    print("GET request not successfull. HTTP status code: \(httpResponse.statusCode)")
                }
                
            }
            else {
                print("ERROR: Not a valid HTTP response")
            }
            
        }
        dataTask.resume()
    }
    
}// End of NetworkOperation Class