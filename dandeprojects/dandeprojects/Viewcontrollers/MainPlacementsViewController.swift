//
//  MainPlacementsViewController.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 16/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit
import SDWebImage
import Toaster

class MainPlacementsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

     let elements=["2016","2015"]
    var sectioncount :Int = 0
    var Placedata = [Array<Dictionary<String, String>>]()
 
    @IBOutlet weak var myCollectionview: UICollectionView!
    var finaldata : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        sdfss.text = datapassed?["CLG_NAME"]
        
        let imagesize = UIScreen.main.bounds.width/3 - 3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: imagesize, height: imagesize)
        
        layout.minimumLineSpacing = 3
        layout.minimumInteritemSpacing = 3
        myCollectionview.collectionViewLayout = layout
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 30)
        serverRequest(idtosend : (datapassed?["CLG_ID"])! )
    }

    @IBOutlet weak var sdfss: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 var datapassed: Dictionary<String, String>?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         sectioncount = section
        return Placedata[section].count
       
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
      return  Placedata.count
    }

    @objc func  tapGuestureCollecView(sender: UITapGestureRecognizer)  {

        if let indexPath = self.myCollectionview?.indexPathForItem(at: sender.location(in: self.myCollectionview)) {
          
             var dataclick = Placedata[indexPath.section ]
             let dicvaluesclick: Dictionary<String,String> =  dataclick [indexPath.row]
            
            Toast(text: "Package Offered " + dicvaluesclick["PLACE_AMOUNT"]!, duration: Delay.short).show()
            
           
     
        } else {
            print("collection view was tapped")
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCollectionViewCell", for: indexPath) as! MainPlacementsCollectionViewCell
        
  let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGuestureCollecView))
        
       
        
        var data = Placedata[indexPath.section ]
        let dicvalues: Dictionary<String,String> = data[indexPath.row]
         let imageUrl : String = dicvalues["PLACE_COMPANY"]!
           let url = URL(string: imageUrl)
        cell.collectionimage.sd_setImage(with: url)
       
        cell.collectionimage.layer.masksToBounds = false
       
        cell.collectionimage.layer.cornerRadius = 5
        cell.collectionimage.clipsToBounds = true
        
        cell.collectionimage.isUserInteractionEnabled = true
          cell.collectionimage.addGestureRecognizer(tapGuesture)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "placementsheader", for: indexPath) as! PlacementsCollectionReusableView
       
        sectionHeaderView.categorytitle.text =  elements[ indexPath.section]
        return sectionHeaderView
    }
    func serverRequest(idtosend: String){
        let WORKSPACE_ID = "HOME_WORKSPACE"
        let FUNCTION_ID = "GET_PLACE_ONLY"
        let ACTION_ID = "GET_ALL_PLACE_STRING"
        
        let Recordtosend = [
            "ACTION_ID" : ACTION_ID,
            "FUNCTION_ID" : FUNCTION_ID,
            "WORKSPACE_ID" : WORKSPACE_ID,
            "SROW_INDEX" : 0 ,
            "EROW_INDEX" : 10,
            "uniqueTosend" : idtosend
            
            ] as [String : Any]
        let jsontosend = [
            "datatohost" : Recordtosend]
        
        if JSONSerialization.isValidJSONObject(jsontosend) {
            if let data = try? JSONSerialization.data(withJSONObject: jsontosend, options: []) {
                print("JSON data object is:\(data)")
                finaldata = String(data: data, encoding: String.Encoding.ascii)!
                print("JSON data object is:\(String(describing: finaldata))")
            }
        }
        
        
        //json data ends
        let serverip = ServerUtility().getServerIP()
        
        let url = URL(string: serverip + "/PlacementsStrings")
        
        
        var request = URLRequest(url: url!)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let postString = "ServerData=" + finaldata
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
            //  guard let responseString = String(data: data, encoding: .utf8) else {return}
            let responseString =  String(data: data, encoding: String.Encoding.ascii)!
            let dict = ServerUtility().convertToDictionary(text: responseString)
            
            for word in dict! {
                //  print(word)
             
              
                let word1king = word.value as! [String : AnyObject]
                   var PlaceCompanies = [Dictionary<String, String>]()
                for word1 in word1king {
                    //  print(word)
                    PlaceCompanies.append(word1.value as! [String : String])
                    
                }
                   self.Placedata.append(PlaceCompanies)
                PlaceCompanies.removeAll()
            }
         
            print("responseString1 = \(String(describing: self.Placedata))")
            
          
            

            DispatchQueue.main.async {
                self.myCollectionview.reloadData()
            }
        }
        task.resume()
        
    }
}
