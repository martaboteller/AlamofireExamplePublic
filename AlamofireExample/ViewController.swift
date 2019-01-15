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
    @IBOutlet weak var imageToShow: UIImageView!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    
    let farm: String = ""
    let id: String = ""
    let secret: String = ""
    let server: String = ""
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequestAPICall( parameters_name: "")
        getImage()
    }
    
    func getImage() {
        //Construct the image path
        //http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        let stringURL = "https://farm5.staticflickr.com/4917/45876742681_a7dc2f2c58.jpg"
        //let stringURL = "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"
        
        let imageURL = URL(string: stringURL)
        do {
            let imageData = try Data(contentsOf: imageURL!)
            imageToShow.image = UIImage(data: imageData)
            
        }catch{
            print (error)
        }
     
    }
    
    
    
    func getRequestAPICall(parameters_name: String)  {
        
       // let todosEndpoint: String = "your_server_url" + "parameterName=\(parameters_name)"
        //let todosEndpoint: String =  "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=c7ababa5d14a6570cff5f8ccf9ad46b2&tags=hello&per_page=1&format=json&nojsoncallback=1"
        
        //let todosEndpoint: String = "https://api.flickr.com/services/rest/?method=flickr.groups.search&api_key=c7ababa5d14a6570cff5f8ccf9ad46b2&text=a&per_page=1&format=json&nojsoncallback=1"
        
        let todosEndpoint: String = "https://api.flickr.com/services/rest/?method=flickr.groups.pools.getphotos&api_key=c7ababa5d14a6570cff5f8ccf9ad46b2&group_id=27034531@N00&tags=a&per_page=1&format=json&nojsoncallback=1"
        
        Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseData { response in
                //debugPrint(response)
                
                if let data = response.result.value {
                    
                   // let data: Data // received from a network request, for example
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    //print(json)
                    
                    if let firstDictionary = json as? [String: AnyObject] {
                        
                        var secondDictionary: [String: AnyObject] = firstDictionary ["photos"] as! [String : AnyObject]
                        
                        
                        let page: Int = secondDictionary["page"] as! Int
                        let pages: Int = secondDictionary["pages"] as! Int
                        let perPage: Int = secondDictionary["perpage"] as! Int
                        let group: NSArray = secondDictionary["photo"] as! NSArray
                        let myGroup: NSDictionary = group[0] as! NSDictionary
                        let dateadded: String = myGroup.value(forKey: "dateadded") as! String
                        let farm: String = String(myGroup.value(forKey: "farm") as! Int)
                        let id: String = myGroup.value(forKey: "id") as! String
                        let isfamily: Int = myGroup.value(forKey: "isfamily") as! Int
                        let isfriend: Int = myGroup.value(forKey: "isfriend") as! Int
                        let ispublic: Int = myGroup.value(forKey: "ispublic") as! Int
                        let owner: String = myGroup.value(forKey: "owner") as! String
                        let ownername: String = myGroup.value(forKey: "ownername") as! String
                        let secret: String = myGroup.value(forKey: "secret") as! String
                        let server: String = myGroup.value(forKey: "server") as! String
                        let title: String = myGroup.value(forKey: "title") as! String
                      
                        print(String(page))
                        print(String((pages)))
                        print(String(perPage))
                        print(dateadded)
                        print(farm)
                        print(id)
                        print(isfamily)
                        print(isfriend)
                        print(ispublic)
                        print(owner)
                        print(ownername)
                        print(secret)
                        print(server)
                        print(title)
                        
                       
                    }
                    
                }
                
              
                
        
                    
                  
        }
    }
        
    
   
   
                        
                        
                
               
               
    
    
        
        
       /* https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=FLICKR_API_KEY&tags=SEARCH_TEXT&per_page=25&format=json&nojsoncallback=1
        
            https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=c7ababa5d14a6570cff5f8ccf9ad46b2&tags=hello&per_page=25&format=json&nojsoncallback=1
        
        c7ababa5d14a6570cff5f8ccf9ad46b2
        
        fde2ddc2ee9971ed
        
        Image Path: https://farmFARM.staticflickr.com/SERVER/ID_SECRET_m.jpg
        Example: https://farm8.staticflickr.com/7859/46664736772_7cdc490af9_m.jpg
 
        
      {"photos":{"page":1,"pages":4288,"perpage":25,"total":"107185","photo":,{"id":"46664736772","owner":"72096526@N04","secret":"7cdc490af9","server":"7859","farm":8,"title":"A Warm Hello","ispublic":1,"isfriend":0,"isfamily":0}  */
        
        
      

    
    

}

