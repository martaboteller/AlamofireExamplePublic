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

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var viewInsideStack: UIView!
    //Variables
    
    var dicName: [Int : String] = [:]
    var dicURL: [String : URL] = [:]
    var dicImages: [Int : UIImage] = [:]
    var dicImages2: [String : UIImage] = [:]
    var finalDic: [Int: UIImage] = [:]
    var alamofireCont: AlamofireController = AlamofireController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var counter: Int = 0
        
        //Get the text from textField
        if dicName.count !=  0 {
            print("I have got the text!")
            
            for (_, value) in dicName {
                
                alamofireCont.getRequestAPICall(letter: value, success: {
                    url in
                    //Save the combination of key - urls
                    self.dicURL = [value : url]
                    //Save the combination of key - images
                    self.dicImages = self.saveImages(dicURL: self.dicURL)
                    
                    //If all images have been saved display them
                    if counter == self.dicName.count - 1 {
                      
                        //Display images
                        self.displayImages(dicImages: self.dicImages)
                    }else{
                        counter += 1
                        print(counter)
                    }
                }){ error in
                    print(error)
                }
            }
            
        }
        
    }
        
        
    @IBAction func refreshButton(_ sender: Any) {
        
        inputText.text = ""
        let subviews = self.stackView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    @IBAction func goButton(_ sender: Any) {
        
        //Retrieve the text
        let inputTxt: String = inputText.text!.replacingOccurrences(of: " ", with: "")
        print(inputTxt)
     
        //If the textField is not empty get the text
        if inputTxt == "" {
            let alertController = UIAlertController(title: "Error", message: "Empty text field", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true)
            
        }else{
            if containsOnlyLetters(input: inputTxt) {
                for i in 0 ... (inputTxt.count - 1) {
                    dicName[i] = inputTxt[i]
                }
                viewDidLoad()
            }else{
                let alertController = UIAlertController(title: "Error", message: "Only letters are allowed", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true)
           }
        
        }
    }
    
    
    
    func displayImages(dicImages: [Int: UIImage]){
        
        let numberImages: Int = dicImages.values.count - 1
        var distance: Int = 0
    
        //Create view as left margin and add it to stackview
        //let myView = UIView(frame: CGRect(x: 10, y: 0, width: 50, height: 50))
        //let myView = UIView(frame: CGRect(x:0, y: 0, width: 50, height: 50))
        
        viewInsideStack.backgroundColor = .yellow
     
        if numberImages < 6 {
            for i in 0 ... numberImages {
                //let newImageView: UIImageView = UIImageView(frame: CGRect(x: distance, y: 0, width: 50, height: 50))
                let newImageView: UIImageView = UIImageView()
                newImageView.image = dicImages[i]
                viewInsideStack.addSubview(newImageView)
                distance += 55
            }
        }else{
            for i in 0 ... numberImages {
                let newImageView: UIImageView = UIImageView(frame: CGRect(x: 5 + distance, y: 0, width: 20, height: 20))
                newImageView.image = dicImages[i]
                viewInsideStack.addSubview(newImageView)
                distance += 25
            }
        }
       
        /*let horizontalContraint = viewInsideStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let verticalContraint = viewInsideStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        let widthlContraint = viewInsideStack.widthAnchor.constraint(equalToConstant: 50)
        let heightContraint = viewInsideStack.heightAnchor.constraint(equalToConstant: 50)
      
        NSLayoutConstraint.activate([horizontalContraint,verticalContraint,widthlContraint,heightContraint])*/
        
        self.stackView.addSubview(viewInsideStack)
        self.stackView.distribution = .fillEqually
        self.stackView.axis = .horizontal
        self.stackView.alignment = .center
        self.stackView.backgroundColor = .orange
        
    }
    
    //Save downloaded images into a dictionary
    func saveImages(dicURL: [String : URL])->[Int: UIImage] {
        
        do {
            
            for i in 0 ... (dicName.count - 1) {
              
                for (key, _) in dicURL {
                    if key == dicName[i] {
                        let imageData = try Data(contentsOf: dicURL[key]!)
                        let image: UIImage = UIImage(data: imageData)!
                        dicImages [i] = image
                    }
                }
            }
        }catch{
            print (error)
        }
        return dicImages
    }
    
    func containsOnlyLetters(input: String) -> Bool {
         let spaceChr = NSCharacterSet.whitespaces
        
            for chr in input {
                if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z")) {
                    return false
                }
            }
            return true
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
