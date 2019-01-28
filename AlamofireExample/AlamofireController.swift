//
//  AlamofireController.swift
//  AlamofireExample
//
//  Created by Marta Boteller on 22/01/2019.
//  Copyright © 2019 Marta Boteller. All rights reserved.
//

import Alamofire
import SwiftyJSON


class AlamofireController {
    
    func getRequestAPICall (letter: String, success:@escaping (_ imageURL: URL)->(),failure:@escaping (_ error:Error)->()){
        
        //Variable declaration
        var farm: String = ""
        var id: String = ""
        var secret: String = ""
        var server: String = ""
        let yourAPIkey: String = "" //Your API Key goes here
        
        //URL to retreive the image
        let todosEndpoint: String = "https://api.flickr.com/services/rest/?method=flickr.groups.pools.getphotos&api_key=\(yourAPIkey)&group_id=27034531@N00&tags=\(letter)&per_page=25&format=json&nojsoncallback=1"
        
        //Alamofire call
        Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
            .responseData { response in
                
                if let data = response.result.value {
                    
                    let json = try? JSONSerialization.jsonObject(with: data, options: [])
                    if let firstDictionary = json as? [String: AnyObject] {
                        
                        var secondDictionary: [String: AnyObject] = firstDictionary ["photos"] as! [String : AnyObject]
                        
                        let group: NSArray  = secondDictionary["photo"] as! NSArray
                        //Random number from 0 to 25
                        let number: Int = Int.random(in: 0 ... 24)
                        let myGroup: NSDictionary  = group[number] as! NSDictionary
                        farm = String(myGroup.value(forKey: "farm") as! Int)
                        id  = myGroup.value(forKey: "id") as! String
                        secret  = myGroup.value(forKey: "secret") as! String
                        server  = myGroup.value(forKey: "server") as! String
                        
                        //Construct the url containing the image
                        //http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
                        let imageURL: URL = URL(string: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")!
                        
                        success(imageURL)
                    }
                }
        }
        
    }
    
    
    
    
}
