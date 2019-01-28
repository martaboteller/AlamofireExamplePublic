//
//  ViewController.swift
//  AlamofireExample
//
//  Created by Marta Boteller on 08/01/2019.
//  Copyright © 2019 Marta Boteller. All rights reserved.
//

import Alamofire
import SwiftyJSON


class ViewController: UIViewController {
  
   
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var verticalStackView: UIStackView!
    @IBOutlet weak var interiorView: UIView!
    @IBOutlet weak var refreshButton: UIButton!
   
    //Variables
    var dicName: [Int : String] = [:]
    var dicURL: [String : URL] = [:]
    var dicImages: [Int : UIImage] = [:]
    var alamofireCont: AlamofireController = AlamofireController()
    var counter: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Get the text from textField
        if dicName.count !=  0 {
   
            //Get image for every letter in the input text
            for (_, value) in dicName {
                alamofireCont.getRequestAPICall(letter: value, success: {
                    url in
                    //Save the combination of key - url
                    self.dicURL = [value : url]
                    //Save the combination of key - image
                    self.dicImages = self.saveImages(dicURL: self.dicURL) //Function saveImages
                    //If all images have been saved display them
                    if self.counter == self.dicName.count - 1 {
                        self.displayImages(dicImages: self.dicImages) //Function displayImages
                    }else{
                        self.counter += 1
                    }
                }){ error in
                    print(error)
                }
            }
            
        }
        
    }
    
    //Clean the screen and reset all variables
    @IBAction func refreshButton(_ sender: Any) {
        
        //Empty input text
        inputText.text = ""
       
        //Remove content of UIView (interiorView)
        let subviews = self.interiorView.subviews
        for i in 0 ... dicImages.values.count - 1 {
            dicImages[i] = nil
            dicName[i] = nil
        }
        for subview in subviews {
            subview.removeFromSuperview()
        }
        //Remove frame
        interiorView.frame = CGRect.zero
        self.counter = 0

    }
    
    //Get image letters according to input text
    @IBAction func goButton(_ sender: Any) {
        
        //Retrieve the text without empty spaces
        let inputTxt: String = inputText.text!.replacingOccurrences(of: " ", with: "")
     
        //If the textField is not empty get the text
        if inputTxt == "" {
            let alertController = UIAlertController(title: "Error", message: "Empty text field", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true)
            
        }else{
            if containsOnlyLetters(input: inputTxt) {
                if inputTxt.count > 13 {
                    let alertController = UIAlertController(title: "Error", message: "Maximum 13 letters allowed", preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true)
                } else {
                    for i in 0 ... (inputTxt.count - 1) {
                        dicName[i] = inputTxt[i] //Use String Extension
                    }
                    viewDidLoad()
                }
            }else{
                let alertController = UIAlertController(title: "Error", message: "Only letters are allowed", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true)
           }
        
        }
    }
    
    //Display images on screen
    func displayImages(dicImages: [Int: UIImage]){
        
        //Variables to construct View Frame
        let numberImages: Int = dicImages.values.count - 1
        var distance: Int = 0
        let viewWidth: Int = (numberImages + 1) * Int(dicImages[0]!.size.width)
        let viewHeight: Int = Int(dicImages[0]!.size.height)
        let xDist: Int =  (Int(self.verticalStackView.bounds.width) - viewWidth)/2
        interiorView.frame = CGRect(x: xDist, y: 0, width: viewWidth,height: viewHeight)
      
        for i in 0 ... numberImages {
                let newImageView: UIImageView = UIImageView(frame: CGRect(x: distance, y: 0, width: Int(dicImages[i]!.size.width), height: Int(dicImages[i]!.size.width)))
                newImageView.image = dicImages[i]
                interiorView.addSubview(newImageView)
                distance += Int(dicImages[i]!.size.width)
        }
    }
    
    //Save downloaded images into a dictionary
    func saveImages(dicURL: [String : URL])->[Int: UIImage] {
        
        do {
            for i in 0 ... (dicName.count - 1) {
                for (key, _) in dicURL {
                    if key == dicName[i] {
                        let imageData = try Data(contentsOf: dicURL[key]!)
                        var image: UIImage = UIImage(data: imageData)!
                        if dicName.count < 6{
                             image = resizeImage(image: image, targetSize: CGSize(width: 50, height: 50))
                        } else {
                             image = resizeImage(image: image, targetSize: CGSize(width: 30, height: 30))
                        } //Change image size depending on number of chars on input text
                        dicImages [i] = image
                    }
                }
            }
        }catch{
            print (error)
        }
        return dicImages
    }
    
    //Function that returns true if input text only contains letters
    func containsOnlyLetters(input: String) -> Bool {
            for chr in input {
                if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z")) {
                    return false
                }
            }
            return true
    }
    
    //Function that changes image size
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    
        
  
}


extension String {
    
    var length: Int {
        return count
    }
    
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }
    
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}



