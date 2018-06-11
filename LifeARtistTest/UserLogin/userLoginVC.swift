//
//  checkbox.swift
//  LifeARtistTest
//
//  Created by Mohamed ELfishawy on 4/7/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON







class userLoginVC: UIViewController {

    @IBOutlet weak var numbertf: UITextField!
    @IBOutlet weak var passwordtf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    @IBAction func loginpressed(_ sender: UIButton) {
        guard let  Number = numbertf.text,!Number .isEmpty else {return}
        guard let password = passwordtf.text,!password .isEmpty else {return}
        APIService.userlogin(Number: Number, password: password){ (error:Error?, success: Bool) in
            if success{
                //ss
            }else{
                //sss
            
            
            }
        }
    }


    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkbox(_ sender: UIButton) {
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
