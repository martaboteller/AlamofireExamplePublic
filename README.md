# Alamofire Example

<table border=0 bordercolorlight=white>
<tr>
<th width=40%>
<img src="https://github.com/martaboteller/AlamofireExamplePublic/blob/master/alamofire.gif?raw=true" width="250" height="500"> 
</th>
<th align="left" width=60%>
  <p>This is a simple example of Alamofire integration.</p>
  
  <p>A simple view has been created with a textField and a couple of buttons (go and refresh).</p>
  <p>
  A Flickr API is called during the Alamofire request. In particular the flickr.groups.pools.getPhotos method has been used to display
  an image from the OneLetter group of images (https://www.flickr.com/groups/oneletter/).
 
 <p> With the refresh button we are able to remove the view content and frames. For a better visualization the number of entered characters has been limited to 13. It has also been imposed that written characters
 must be letters and not numbers or symbols. </p>
  
</th>
</tr>
</table>


&nbsp;

## Deployment

1st step: Acquire an API Key 

Learn how to create an API Key [here](https://www.flickr.com/services/api/misc.api_keys.html)

&nbsp;

2nd step: Define the Alamofire request call
```
//Alamofire call
Alamofire.request(todosEndpoint, method: .get, encoding: JSONEncoding.default)
       .responseData { response in
```
&nbsp;


3rd step: Serialize JSON result and construct the image url
```
//Json serialization
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
                        
```
&nbsp;

4th step: Control emtpy spaces, numbers and symbols displaying an alert if necessary
```
//Displaying an alert
let alertController = UIAlertController(title: "Error", message: "Empty text field", preferredStyle: .alert)
let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
alertController.addAction(defaultAction)
self.present(alertController, animated: true)
```
&nbsp;

5th step: Programmly add UIImageViews to UIView inside a StackView 
```
//Add images into UIView
for i in 0 ... numberImages {
   let newImageView: UIImageView = UIImageView(frame: CGRect(x: distance, y: 0, width: Int(dicImages[i]!.size.width), height: Int(dicImages[i]!.size.width)))
   newImageView.image = dicImages[i]
   interiorView.addSubview(newImageView)
   distance += Int(dicImages[i]!.size.width)
}

//Function that resizes images to fit the screen
...

```

&nbsp;


### Result

Please feel free to send me an email should you need further information.

## Built With

* XCode 10.1
* Swift 4.2
* Platform IOS 12.0

## Versioning

First version finished on Jan 2019.

## Authors

* **Marta Boteller** - [Marta Boteller](https://github.com/martaboteller).
