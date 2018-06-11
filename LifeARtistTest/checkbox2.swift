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
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }


}
