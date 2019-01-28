# Alamofire Example

<table border=0 bordercolorlight=white>
<tr>
<th width=40%>
<img src="https://github.com/martabotellter/KVOExample/resources/kvo.gif?raw=true" width="300" height="450"> 
</th>
<th align="left" width=60%>
  <p>This is a simple example of Alamofire integration.</p>
  
  <p>A simple view has been created with a textField and a couple of buttons (go and refresh).</p>
  <p>
  A Flickr API is called during the Alamofire request. In particular the flickr.groups.pools.getPhotos method has been used to display
  an image from the OneLetter group of images (https://www.flickr.com/groups/oneletter/).
  With the refresh button we are able to remove the view content and frames.
  
 <p> For a better visualization the number of entered characters has been limited to 13. It has also been imposed that written characters
 must be letters and not numbers or symbols. </p>
  
</th>
</tr>
</table>


&nbsp;

## Deployment

1st step: Adquire an API Key 

Learn how to create an API Key [here](https://www.flickr.com/services/api/misc.api_keys.html)

&nbsp;

2nd step: create an observable property for the textField
```
@objc dynamic var inputText: String?
```
&nbsp;


3rd step: define an observer for new values of the property inputText
```
inputTextObservationToken = observe(\.inputText, options: .new, changeHandler: {(vc,change) in
     guard let updatedInputText = change.newValue as? String else {return}
          if self.contacts.contains(updatedInputText) {
                vc.existingLabel.text = "Contact already exists!"
                self.addButton.isEnabled = false
          }else{
                vc.existingLabel.text = ""
                self.addButton.isEnabled = true
          }
})
```
&nbsp;

4th step: assign the value of textField.text to the observable property
```
@IBAction func textFieldTextDidChange() {
      inputText = textField.text
}
```
&nbsp;

5th step: invalidate the observation token 
```
override func viewWillDisappear(_ animated: Bool) {
   super.viewWillDisappear(animated)
   inputTextObservationToken!.invalidate()
}
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
