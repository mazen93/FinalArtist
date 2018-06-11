//
//  providerAdds.swift
//  LifeARtistTest
//
//  Created by mohamed on 6/10/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import ImagePicker
import Lightbox
class providerAdds: UIViewController,ImagePickerDelegate {
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var collection2: UICollectionView!
     var array:[providerModel]=[]
 

    
    
    
    
    
    
    
    
    func loadimageData()  {
        
             let userID = UserDefaults.standard.string(forKey: "providerId")
        
        let url="http://live-artists.com/admin/api/show/images/\(userID)"
        //let url = URLs.oldOrder
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[providerModel]()
                    
                    let json = JSON(value)
                    // print(json)
                    
                    if let dataArr = json["images"]["data"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                            let ar=providerModel()
                            if
                                let icon = dataArr ["url"].string
                                
                            {
                                //                                ar.id=id
                                ar.icon = icon
                                //
                                
                                
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.collection.reloadData()
                        
                    }
                    
                    
                }
        }
        
        
        
        
        
        
        
        
    }
    
    
    
    func loadVideoData()  {
        
              let userID = UserDefaults.standard.string(forKey: "providerId")
        
        
        let url = "http://live-artists.com/admin/api/show/videos/\(userID)"
        
        
        
        
        Alamofire.request(url, method: .get, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[providerModel]()
                    
                    let json = JSON(value)
                    // print(json)
                    
                    
                    
                    
                    if let dataArr = json["videos"]["data"].array
                    {
                        
                        
                        
                        for dataArr in dataArr {
                            let ar=providerModel()
                            if let video = dataArr ["url"].string
                                
                            {
                                //                                ar.id=id
                                ar.url = confic.imagePath+video
                                //                                ar.icon=icon
                            }
                            
                            
                            
                            
                            self.array.append(ar)
                        }
                        
                        self.collection2.reloadData()
                        
                    }//
                    
                    
                }
        }
        
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "providerCell", for: indexPath) as! providerCell
            if collectionView == self.collection {
                let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "providerCell", for: indexPath) as! providerCell
                let resource=ImageResource(downloadURL: URL(string: array[indexPath.row].icon)!, cacheKey: array[indexPath.row].icon)
                cell.profileimage.kf.setImage(with: resource)
                
                return cell
            }
            if collectionView == self.collection2 {
                let cell2=collectionView.dequeueReusableCell(withReuseIdentifier: "providerVideoCell", for: indexPath) as! proiderVideoCell
                
                let s=URL(string: array[indexPath.row].url)
                let url=URLRequest(url: s!)
                cell2.webView.loadRequest(url)
                return cell2
                
            }
            
            
            
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("image number \(indexPath.row)")
            // v=array[indexPath.row]
            //
            //        print("image number \(array[indexPath.row].id)")
            //        performSegue(withIdentifier: "go", sender: array[indexPath.row])
            
            
            //let vc=UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VC2") as! VC2
            //  vc.firstCategoryId = array[indexPath.row].title
            //  self.present(vc, animated: true, completion: nil)
            
            
            
            
            
        }
    //
        
        lazy var button: UIButton = self.makeButton()
        
        @IBOutlet weak var img: UIImageView!
        override func viewDidLoad() {
            super.viewDidLoad()
            
            view.backgroundColor = UIColor.white
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            view.addConstraint(
                NSLayoutConstraint(item: button, attribute: .centerX,
                                   relatedBy: .equal, toItem: view,
                                   attribute: .centerX, multiplier: 1,
                                   constant: 0))
            
            view.addConstraint(
                NSLayoutConstraint(item: button, attribute: .centerY,
                                   relatedBy: .equal, toItem: view,
                                   attribute: .centerY, multiplier: 1,
                                   constant: 0))
        }
        
        func makeButton() -> UIButton {
            let button = UIButton()
            button.setTitle("Show ImagePicker", for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
            button.addTarget(self, action: #selector(buttonTouched(button:)), for: .touchUpInside)
            
            return button
        }
        
        @objc func buttonTouched(button: UIButton) {
            var config = Configuration()
            config.doneButtonTitle = "Finish"
            config.noImagesTitle = "Sorry! There are no images here!"
            config.recordLocation = false
            config.allowVideoSelection = true
            
            let imagePicker = ImagePickerController(configuration: config)
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion: nil)
        }
        
        // MARK: - ImagePickerDelegate
        func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
            imagePicker.dismiss(animated: true, completion: nil)
        }
        
        func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
            guard images.count > 0 else { return }
            
            let lightboxImages = images.map {
                return LightboxImage(image: $0)
            }
            
            let lightbox = LightboxController(images: lightboxImages, startIndex: 0)
            imagePicker.present(lightbox, animated: true, completion: nil)
        }
        
        func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
            
            loadServices(images: images)
            imagePicker.dismiss(animated: true, completion: nil)
            
        }
        
 
        
        func newServer(images:[UIImage]){
            
            
            
            let providerID=UserDefaults.standard.string(forKey: "providerId")
            
            let url = "http://live-artists.com/admin/api/add/images"
            let parameters = [
                "provider_id" : providerID
                
            ]
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    
                    for (key,value) in parameters {
                        if let value = value as? String {
                            multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                        }
                    }
                    
                    for (image) in images {
                        if  let imageData = UIImageJPEGRepresentation(image, 0.6) {
                            multipartFormData.append(imageData, withName: "url", fileName: "image.jpeg", mimeType: "image/jpeg")
                        }
                    }
            },
                to: url,
                method: .post,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            print(progress)
                            
                        })
                        
                        upload.responseJSON { response in
                            
                            // If the request to get activities is succesfull, store them
                            if response.result.isSuccess{
                                print(response.debugDescription)
                                 loadimageData()
                            } else {
                                
                                
                                var errorMessage = "ERROR MESSAGE: "
                                if let data = response.data {
                                   
                                }
                                print(errorMessage) //Contains General error message or specific.
                                print(response.debugDescription)
                            }
                            
                            
                        }
                    case .failure(let encodingError):
                        print("FALLE ------------")
                        print(encodingError)
                    }
            }
            )
        }
        
        
    }
    
 

}
