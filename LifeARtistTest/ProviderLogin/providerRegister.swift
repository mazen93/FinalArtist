//
//  providerRegister.swift
//  LifeARtistTest
//
//  Created by mohamed on 6/10/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import LocationPicker
import CoreLocation

class providerRegister: UIViewController {

    @IBOutlet weak var about: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var number: UITextField!
    @IBOutlet weak var tradeMark: UITextField!
    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var locationNameButton: UIButton!
     var locationString:String="location"
    var lat=""
    var long=""
    var locati:CLLocationDegrees?
    var lati:CLLocationDegrees?
    var location: Location? {
        didSet {
            //            locationNameLabel.text = location.flatMap({ $0.title }) ?? "No location selected"
            let loc=location.flatMap({ $0.title }) ?? "Location"
            
            locationNameButton.setTitle(loc,for: .normal)
            self.locationString=loc
            
            print(location?.coordinate.latitude)
            locati=location?.coordinate.latitude
            lat=String(describing: locati)
            
            long=String(describing: location?.coordinate.longitude)
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LocationPicker" {
            let locationPicker = segue.destination as! LocationPickerViewController
            locationPicker.location = location
            locationPicker.showCurrentLocationButton = true
            locationPicker.useCurrentLocationAsHint = true
            locationPicker.selectCurrentLocationInitially = true
            
            locationPicker.completion = { self.location = $0 }
        }
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func registerpassed(_ sender: UIButton) {
        guard let  username = firstnameTF.text?.trimmed, !username.isEmpty, let fullname = fullNameTF.text?.trimmed,!fullname .isEmpty, let email = emailTF.text?.trimmed,!email.isEmpty, let password = passwordTF.text, !password.isEmpty,let Number = number.text?.trimmed, !Number.isEmpty  else { return }
        
        
        APIService.registerProvider(fullName: fullname, userName: username, email: email, password: password, Number: Number, image:imageV.image!, about: about.text!, address: address.text!, lat: lat, long: long, tradeName:tradeMark.text! ){
            (_ error: Error?, _ success:Bool) in
            if success {
                print("welcome to our app")
            }else{
                print("x")
            }
        
       
        
    }

}
}
