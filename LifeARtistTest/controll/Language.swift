//
//  Language.swift
//  LifeARtistTest
//
//  Created by mohamed on 6/10/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit

class Language: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    private func changeLanguage(langCode:String){
        if Bundle.main.preferredLocalizations.first != langCode{
          
            let confirmAlertCtrl=UIAlertController(title: restart, message: "will restart app", preferredStyle: .alert)
            
            let confirmAction=UIAlertAction(title: "close", style: .destructive){ _ in
                UserDefaults.standard.set((langCode), forKey: "AppleLanguages")
                UserDefaults.standard.synchronize()
                exit(EXIT_SUCCESS)
            }
            confirmAlertCtrl.addAction(confirmAction)
            let cancel=UIAlertAction(title: "cancel", style: .cancel, handler: nil)
            confirmAlertCtrl.addAction(cancel)
            present(confirmAlertCtrl, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func englishButton(_ sender: Any) {
       
        changeLanguage(langCode: "en")
        
        
      
    }
    
    @IBAction func arabicButton(_ sender: Any) {
        
        self.changeLanguage(langCode: "ar")
        
        

        
        
    }
    
}
