//
//  registerVC.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/11/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class userRegisterVC: UIViewController {
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var lastnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var numberTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

}
    @IBAction func registerpassed(_ sender: UIButton) {
        guard let  firstname = firstnameTF.text?.trimmed, !firstname.isEmpty, let lastname = lastnameTF.text?.trimmed,!lastname.isEmpty, let email = emailTF.text?.trimmed,!email.isEmpty, let password = passwordTF.text, !password.isEmpty,let Number = numberTF.text?.trimmed, !Number.isEmpty  else { return }
        
      
        
        APIService.register(firstname: firstname, lastname: lastname, email: email, password: password, Number: Number) { (_ error: Error?, _ success:Bool) in
            if success {
                print("welcome to our app")
            }
        }
      
    }
    
}
