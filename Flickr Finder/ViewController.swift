//
//  ViewController.swift
//  Flickr Finder
//
//  Created by Carl Argabright on 12/17/15.
//  Copyright © 2015 Carl Argabright. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tapRecognizer: UITapGestureRecognizer? = nil
    
    //////////////////////////////////////////////////////
    //     THE OUTLETS ASSOCIATED WITH THE VIEW ITEMS
    /////////////////////////////////////////////////////
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var searchByDescription: UITextField!
    @IBOutlet weak var searchByLattitude: UITextField!
    @IBOutlet weak var searchByLongitude: UITextField!
    
    
    
    //////////////////////////////////////////////////////
    //              API FETCHING STUFF
    /////////////////////////////////////////////////////
    private let forecastAPIKey = "5f159228b11e59e1f95bcef15e1d1283"
    let coordinate:(lat: Double, long: Double) = (37.8267,-122.423)
    
    /////////////////////////////////////////////////////
    //             Flickr Constants
    /////////////////////////////////////////////////////
    /* 1 - Define constants */
    // MARK: - Globals
    let BASE_URL = "https://api.flickr.com/services/rest/"
    let METHOD_NAME = "flickr.photos.search"
    let API_KEY = "ae369b9f4b35030234a9de1c3567d2cc"
    let EXTRAS = "url_m"
    let SAFE_SEARCH = "1"
    let DATA_FORMAT = "json"
    let NO_JSON_CALLBACK = "1"


    
    // https:method=flickr.photos.search&api_key=f83c02dcf6a7082d895b9c2b525c324b&text=tree+frogs&format=json&nojsoncallback=1&auth_token=72157662605107665-36afc0308a8ce44c&api_sig=5fd912560c69f49e054298679db5ff08
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        tapRecognizer = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        tapRecognizer?.numberOfTapsRequired = 1


        
    }
    
    
    func configureView() {

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: - Retrieve photos from Flickr
    
    
    @IBAction func getPhotoFromFlickr(sender: AnyObject) {
        
        self.dismissAnyVisibleKeyboards()
        
        let methodArguments: [String: String!] = [
            "method": METHOD_NAME,
            "api_key": API_KEY,
            "text": self.searchByDescription.text,
            "safe_search": SAFE_SEARCH,
            "extras": EXTRAS,
            "format": DATA_FORMAT,
            "nojsoncallback": NO_JSON_CALLBACK
        ]
        //getImageFromFlickrBySearch(methodArguments)
        
        let urlString = BASE_URL + escapedParameters(methodArguments)
        print(urlString)
        
        
        
        
        print("You pushed the button!")

        // 1. Get the photos
        //let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=ae369b9f4b35030234a9de1c3567d2cc&text=baby+asian+elephant&format=json&nojsoncallback=1"
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
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        /* Add tap recognizer to dismiss keyboard */
        self.addKeyboardDismissRecognizer()
        
        /* Subscribe to keyboard events so we can adjust the view to show hidden controls */
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        /* Remove tap recognizer */
        self.removeKeyboardDismissRecognizer()
        
        /* Unsubscribe to all keyboard events */
        self.unsubscribeToKeyboardNotifications()
    }
    
    // MARK: Show/Hide Keyboard
    
    func addKeyboardDismissRecognizer() {
        self.view.addGestureRecognizer(tapRecognizer!)
    }
    
    func removeKeyboardDismissRecognizer() {
        self.view.removeGestureRecognizer(tapRecognizer!)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.photoImageView.image != nil {
            //self.defaultLabel.alpha = 0.0
        }
        if self.view.frame.origin.y == 0.0 {
            self.view.frame.origin.y -= self.getKeyboardHeight(notification) / 2
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.photoImageView.image == nil {
            //self.defaultLabel.alpha = 1.0
        }
        if self.view.frame.origin.y != 0.0 {
            self.view.frame.origin.y += self.getKeyboardHeight(notification) / 2
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        print(keyboardSize.CGRectValue().height)
        return (keyboardSize.CGRectValue().height)
    }
 
    
    
    func escapedParameters(parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
            
            /* Make sure that it is a string value */
            let stringValue = "\(value)"
            
            /* Escape it */
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            /* Append it */
            urlVars += [key + "=" + "\(escapedValue!)"]
            
        }
        
        return (!urlVars.isEmpty ? "?" : "") + urlVars.joinWithSeparator("&")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}// End of view controller class


/* =============================================================*/








extension ViewController {
    func dismissAnyVisibleKeyboards() {
        if photoTitleLabel.isFirstResponder(){
            self.view.endEditing(true)
        }
    }
}




/*
extension ViewController {
    func dismissAnyVisibleKeyboards() {
        if phraseTextField.isFirstResponder() || latitudeTextField.isFirstResponder() || longitudeTextField.isFirstResponder() {
            self.view.endEditing(true)
        }
    }
}


*/