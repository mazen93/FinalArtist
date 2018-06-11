//
//  checkbox2.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/11/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class providerLogin: UIViewController {

    @IBAction func checkbox2(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    
    
    @IBOutlet weak var emailtf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func loginpressed(_ sender: UIButton) {
        guard let  Email = emailtf.text,!Email .isEmpty else {return}
        guard let password = passwordtf.text,!password .isEmpty else {return}
      
        
        APIService.providerlogin(username: Email
        , password: password ) { (error:Error?, success: Bool) in
            if success{
                //ss
            }else{
                //sss
                
                
            }
        }
}
}
