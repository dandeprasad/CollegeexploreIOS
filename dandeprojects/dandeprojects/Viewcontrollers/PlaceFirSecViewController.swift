//
//  SecondViewController.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 27/10/17.
//  Copyright © 2017 dande reddyprasad. All rights reserved.
//

import UIKit
import SDWebImage
class PlaceFirSecViewController: UIViewController,UITableViewDelegate,UITableViewDataSource ,UICollectionViewDelegate,UICollectionViewDataSource{
     var finaldata : String = ""
    var DatafromServer = [Dictionary<String, String>]()
     var collegeinfo = [Dictionary<String, String>]()
    var clsStreamid = ""
              let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)

    
    @IBOutlet weak var tableviewdan: UITableView!
    
    @IBOutlet weak var collectionViewdan: UICollectionView!

    var  dataloadover:Bool = true ;
    override func viewDidLoad() {
        super.viewDidLoad()
        tableviewdan.delegate=self
        tableviewdan.dataSource=self
        clsStreamid = "NIT"
        //call server
    serverRequest()
        CollegesserverRequest(startIndex : 0 , endIndext : 10 , StreamidTosend: clsStreamid)
        
    }

    
    
    //for main table view starts
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeinfo.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
  
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableviewdan.tableFooterView = spinner
            self.tableviewdan.tableFooterView?.isHidden = false
        }
        
        
        
        
        let lastElement = collegeinfo.count - 1
        if indexPath.row == lastElement {
            if(dataloadover){
             CollegesserverRequest(startIndex : lastElement+1 , endIndext : lastElement+11 , StreamidTosend: clsStreamid)
            }
          
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableviewdan.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        let dande = collegeinfo[indexPath.row]
        //  userImageref.sd_setImage(with: URL(string: pic), placeholderImage: UIImage(named: "placeholder.png"))
        let collegelogo : String = dande["CLG_LOGO"]!
        let collegename : String = dande["CLG_NAME"]!
         let streamtype : String = dande["DEPARTMENTS"]!
         let url = URL(string: collegelogo)
       // let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGuesture))
        cell.Tabletext.text = collegename
        cell.tableimage.sd_setImage(with: url)
        cell.streamType.text = streamtype
     //   cell.tableimage.image=UIImage(named: elements[indexPath.row])
        cell.tableimage.layer.cornerRadius = cell.tableimage.frame.height / 2
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 5
        cell.cellView.isUserInteractionEnabled = true
      //  cell.cellView.addGestureRecognizer(tapGuesture)
        return cell
    }
    @objc func  tapGuesture()  {
        let alert = UIAlertController(title: "Image", message: "Image message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler : { ACTION in
            print("DANDE")
        } )
        alert.addAction(okAction)
        self.present(alert, animated: true , completion: nil)
        
    }
    @objc func  tapGuestureCollecView(sender: UITapGestureRecognizer)  {

        if let indexPath = self.collectionViewdan?.indexPathForItem(at: sender.location(in: self.collectionViewdan)) {
        
            print("you can do something with the cell or index path here")
           let dande = DatafromServer[indexPath.row]
      

        let streamId1 : String = dande["STREAM_ID"]!
        clsStreamid = streamId1
        collegeinfo.removeAll()
        dataloadover = true
        CollegesserverRequest(startIndex : 0 , endIndext : 10 , StreamidTosend : clsStreamid)
            
        } else {
            print("collection view was tapped")
        }
    }
    //for main table view ends
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DatafromServer.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlacmntCollectionViewCell", for: indexPath) as! PlacmntCollectionViewCell
        let dande = DatafromServer[indexPath.row]
       //  userImageref.sd_setImage(with: URL(string: pic), placeholderImage: UIImage(named: "placeholder.png"))
        let imageUrl : String = dande["STREAM_IMAGE"]!
          let stream : String = dande["STREAM"]!
         // let streamId1 : String = dande["STREAM_ID"]!
        
          let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(self.tapGuestureCollecView))
        
        let url = URL(string: imageUrl)
        cell.StreamsImage.sd_setImage(with: url)
        cell.StreamsLabel.text = stream
        cell.StreamsLabel.textColor = UIColor.white
         cell.StreamsLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        cell.StreamsImage.layer.masksToBounds = false
        // cell.ImgImage.layer.borderColor = UIColor.black
        cell.StreamsImage.layer.cornerRadius = cell.StreamsImage.frame.height/2
        cell.StreamsImage.clipsToBounds = true
        
          cell.StreamsImage.isUserInteractionEnabled = true
           cell.StreamsImage.addGestureRecognizer(tapGuesture)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch(segue.identifier ?? "") {
      
        case "ShowDetails":
            guard let mainPlacementsViewController = segue.destination as? MainPlacementsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMealCell = sender as? CustomTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableviewdan.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let Passingdata = collegeinfo[indexPath.row]
            mainPlacementsViewController.datapassed = Passingdata
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }

    func serverRequest(){
        
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        
    let WORKSPACE_ID = "HOME_WORKSPACE"
    let FUNCTION_ID = "GET_CUTOFFS_FIRST"
    let ACTION_ID = "GET_CUTOFFS_FIRST_STRING"
    
    let Recordtosend = [
        "ACTION_ID" : ACTION_ID,
        "FUNCTION_ID" : FUNCTION_ID,
        "WORKSPACE_ID" : WORKSPACE_ID
        
        ]
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
        
    let url = URL(string: serverip + "/CutoffsFirstString")
  
    
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
         self.dismiss(animated: false, completion: nil)
        
        if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
            print("statusCode should be 200, but is \(httpStatus.statusCode)")
            print("response = \(String(describing: response))")
        }
        
      //  guard let responseString = String(data: data, encoding: .utf8) else {return}
       let responseString =  String(data: data, encoding: String.Encoding.ascii)!
        let dict = ServerUtility().convertToDictionary(text: responseString)
        for word in dict! {
          //  print(word)
            self.DatafromServer.append(word.value as! [String : String])
           
        }
    
        print("responseString = \(String(describing: self.DatafromServer))")
        
     //   let dict1 : Dictionary<String,String> = dict!["0"] as! Dictionary
    //    let vakues:String =    dict1["RESULTCODE"]!
    
        
        
        DispatchQueue.main.async {
            self.collectionViewdan.reloadData()
        }
        
    }
    task.resume()
        
    }
    func CollegesserverRequest(startIndex: Int, endIndext: Int , StreamidTosend : String){
        
//        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        loadingIndicator.startAnimating();
//
//        alert.view.addSubview(loadingIndicator)
//        present(alert, animated: true, completion: nil)
//
        
        
        let WORKSPACE_ID = "HOME_WORKSPACE"
        let FUNCTION_ID = "GET_STREAMS_ONLY"
        let ACTION_ID = "GET_CLG_STREAMS_STRING"
        let  startdataIndex = startIndex
        let  endDataindex = endIndext
        let uniqueTosend = StreamidTosend
        let Recordtosend = [
            "ACTION_ID" : ACTION_ID,
            "FUNCTION_ID" : FUNCTION_ID,
            "WORKSPACE_ID" : WORKSPACE_ID,
            "SROW_INDEX" : startdataIndex,
            "EROW_INDEX" : endDataindex,
            "uniqueTosend" : uniqueTosend
            
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
        
        let url = URL(string: serverip + "/CutoffStreams")
        
        
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
             // self.dismiss(animated: false, completion: nil)
           self.spinner.stopAnimating()
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
            }
            
           // let responseString = String(data: data, encoding: .utf8) as! String
          let responseString =  String(data: data, encoding: String.Encoding.ascii)!
            let dict = ServerUtility().convertToDictionary(text: responseString)
            if( dict?.count==0){
                 self.dataloadover = false
                 
                return
            }
            for word in dict! {
                //  print(word)
                self.collegeinfo.append(word.value as! [String : String])
                
            }
            
            print("responseString = \(String(describing: self.DatafromServer))")
            
            //   let dict1 : Dictionary<String,String> = dict!["0"] as! Dictionary
            //    let vakues:String =    dict1["RESULTCODE"]!
            
          
            
            DispatchQueue.main.async {
                self.tableviewdan.reloadData()
            }
            
        }
        task.resume()
        
    }
}

