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
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    
    
    
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


        
    }
    
    
    func configureView() {

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: - Retrieve photos from Flickr
    
    
    @IBAction func getPhotoFromFlickr(sender: AnyObject) {
        print("You pushed the button!")

        // 1. Get the photos
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=ae369b9f4b35030234a9de1c3567d2cc&text=baby+asian+elephant&format=json&nojsoncallback=1"
        let flickerService = FlickrService(FlickerAPIKey: urlString)
        flickerService.getDictionaryObject {
            (let currentPhotoDictionary) in
            if let photoDictionary = currentPhotoDictionary {
            
                // 2. Determin the number of photos
                let totalPhotos = photoDictionary.photos.count
                    print("There are \(totalPhotos) total photos")
                
                let randomPhotoIndex = Int(arc4random_uniform(UInt32(totalPhotos)))
                print("Random index is \(randomPhotoIndex)")
                let randomPhoto = photoDictionary.photos[randomPhotoIndex]
                print("Random photo is \(randomPhoto)")
                
                let photoURL = NSURL(string: randomPhoto.url!)
                
                
            
                let imageData = NSData(contentsOfURL: photoURL!)
                    dispatch_async(dispatch_get_main_queue(), {
                        self.photoImageView.image = UIImage(data: imageData!)
                        self.photoTitleLabel.text = "\(randomPhoto.title!)"
                    })
            
            }

    

        }

    }
// End of getPhotoFromFlickr()


    
    //////////////////////////////////////////////////////
    //              Keyboard Modifications
    /////////////////////////////////////////////////////
    
    
    
    
}// End of view controller class

