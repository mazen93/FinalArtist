//
//  ResultVC.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/20/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class ResultVC: UIViewController {
  
    
    @IBOutlet weak var tableView: UITableView!
    
    var array:[ResultVCModel]=[]
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

     //  loadData()
     //  loadHalfData()
         loadSkipData()
//
//        if Shared.shared.filterResult == "skip" {
//            print("skip")
//            loadSkipData()
//
//        }
////
//        else{
//
//            print("search")
//            print("3")
//                loadHalfData()
//
//
//
//    }
    }

    
    // load skip Value
    
    
    func loadSkipData()  {
        
 
        let url = "http://live-artists.com/admin/api/search/service/providers?page=1"
      
        
     
        
        
        Alamofire.request(url, method: .post, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[ResultVCModel]()
                    let json = JSON(value)
                    print(json)
                    if let dataArrr = json["data"].array
                    {
                        let ar=ResultVCModel()
                        for dataArr in dataArrr {
                            if let name = dataArr ["username"].string,
                                let photo = dataArr ["image"].string,
                                let id = dataArr["id"].int
                            {
                                ar.name=name
                                print("name\(name)")
                                ar.photo=photo
                                ar.providerID=id
                                
                            }
                            
                            
                            if let rat=dataArr["rates"].array{
                                for dataArr in rat{
                                    if let rate=dataArr["rate"].string,let ratee=Double(rate){
                                        ar.rate=ratee
                                        print(ratee)
                                    }
                                }
                            }
                            
                            if let serv=dataArr["services"].array{
                                for dataArr in serv{
                                    if let service=dataArr["name"].string,
                                        let price=dataArr["price"].string
                                    {
                                        ar.serviceName=service
                                        ar.servicePrice=price
                                        print("service\(service)")
                                        print("price\(price)")
                                    }
                                }
                            }
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                }
                
                
        }
        
        
    }
    
    //load 3 data only
    
    
    func loadHalfData()  {
        
        let url = "http://live-artists.com/admin/api/search/service/providers?page=1"
//       let location=Shared.shared.locationResult
      let serviceID=Shared.shared.filterServiceID
    let serv=Shared.shared.servResult
 
        let parameters = [
        
            
//            "serviceType":serviceID,
//            "search":serv
            "serviceType":"1",
            "search":"ok"
            
//            "location":location,
//            "servise":service,
//            "serv":serv
            
            ]
        
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case .success(let value):
                    self.array=[ResultVCModel]()
                    let json = JSON(value)
                    print(json)
                    if let dataArrr = json["data"].array
                    {
                         let ar=ResultVCModel()
                        for dataArr in dataArrr {
                            if let name = dataArr ["username"].string,
                                let photo = dataArr ["image"].string,
                                let id = dataArr["id"].int
                            {
                                ar.name=name
                                print("name\(name)")
                                ar.photo=photo
                                ar.providerID=id
                                
                            }
                        
                       
                            if let rat=dataArr["rates"].array{
                                for dataArr in rat{
                                    if let rate=dataArr["rate"].string,let ratee=Double(rate){
                                     ar.rate=ratee
                                     print(ratee)
                                }
                            }
                            }
                        
                            if let serv=dataArr["services"].array{
                                for dataArr in serv{
                                    if let service=dataArr["name"].string,
                                        let price=dataArr["price"].string
                                    {
                                        ar.serviceName=service
                                        ar.servicePrice=price
                                        print("service\(service)")
                                        print("price\(price)")
                                    }
                                }
                                }
                            self.array.append(ar)
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                }
                    
                    
                }
        
                
                
    
                
                
                
                
                
        }
        

    
    
    
    
}

// MARK: - TableView

extension ResultVC:UITableViewDataSource,UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultVCCell", for: indexPath) as! ResultVCCell
     
                cell.prize.text=array[indexPath.row].servicePrice
                cell.service.text=array[indexPath.row].serviceName
                cell.cosmosView.rating=array[indexPath.row].rate
                cell.name.text=array[indexPath.row].name
//        let resource=ImageResource(downloadURL: URL(string: array[indexPath.row].photo)!, cacheKey: array[indexPath.row].photo)
//        cell.photo.kf.setImage(with: resource)
        
        
        
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
 
        let m=array[indexPath.row].providerID
        
        Shared.shared.resultProviderID = String(m)
      performSegue(withIdentifier: "fromResult", sender: self)
        
    }
}




