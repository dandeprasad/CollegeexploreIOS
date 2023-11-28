//
//  FirstViewController.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 27/10/17.
//  Copyright © 2017 dande reddyprasad. All rights reserved.
//

import UIKit
import GoogleSignIn
import SDWebImage
class UserLoginViewController: UIViewController , GIDSignInUIDelegate,GIDSignInDelegate{


// google login 
    var serverip:String = "";
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
          //  let userId = user.userID                  // For client-side use only!
         //   let idToken = user.authentication.idToken // Safe to send to the server
            let fullName:NSString = user.profile.name! as NSString
            var usr_infopass : String = ""
            var finaldata : String = ""
           
          //  let givenName = user.profile.givenName
           // let familyName = user.profile.familyName
            let email:NSString  = user.profile.email! as NSString
            if(!(email=="")){
                userMail.text=email as String
            }
            var imagetopass:String  = "";
            if(user.profile.hasImage){
                let dimension = round(30 * UIScreen.main.scale)
               let pic:String  = user.profile.imageURL(withDimension: UInt(dimension)).absoluteString
                imagetopass=pic
              //  let userimage = user.profile.imageURL(withDimension: UInt(dimension))
                userImageref.sd_setImage(with: URL(string: pic), placeholderImage: UIImage(named: "placeholder.png"))
            }
//json data for sending starts
            

            
            let jsonDict = [
                "LOGIN_TYPE" : "GOOGLE_LOGIN",
                "USERNAME_EMAIL" : email,
                "USERNAME" : fullName,
                "PASSWORD":"",
                "USER_IMAGE":imagetopass,
                "deviceName": deviceName(),
                "deviceMan": "Apple"
                ] as! [String : String]
            if JSONSerialization.isValidJSONObject(jsonDict) {
                if let data = try? JSONSerialization.data(withJSONObject: jsonDict, options: []) {
                    print("JSON data object is:\(data)")
                   // usr_infopass = UserLoginViewController.stringify(json: data)
 usr_infopass = String(data: data, encoding: String.Encoding.ascii)!

                }
            }
//            var messageDictionary : [String: Any] = [ "sender": "system1@example.com", "recipients":"system2@example.com", "data": [ "text": "Test Message" ], ]
//            let jsonData = try? JSONSerialization.data(withJSONObject: messageDictionary, options: []){
//            let jsonString = String(data: jsonData, encoding: String.Encoding.ascii)!
//            print (jsonString)
//            }
            
            let WORKSPACE_ID = "USER_LOGIN_WORKSPACE";
            let FUNCTION_ID = "USER_LOGIN_FORALL";
            let ACTION_ID = "LOGIN_MANUAL";
            
            let Recordtosend = [
                "ACTION_ID" : ACTION_ID,
                "FUNCTION_ID" : FUNCTION_ID,
                "WORKSPACE_ID" : WORKSPACE_ID,
                "user_info":usr_infopass,
             
                ]
//            if JSONSerialization.isValidJSONObject(Recordtosend) {
//                if let data  = try? JSONSerialization.data(withJSONObject: Recordtosend, options: []) {
//                    print("JSON data object is:\(data)")
// Record = String(data: data, encoding: String.Encoding.ascii)!
//                  jsconData  = data as NSData
//                }
//            }
         
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
            
            let url = URL(string: serverip + "/UserRegistrationPassWay")
          //    let url = URL(string: "http://localhost:9544/CollegeGuideWorkSpace/UserRegistrationPassWay")
            
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
                
                guard let responseString = String(data: data, encoding: .utf8) else {return}
                
                let dict = self.convertToDictionary(text: responseString)
                 print("responseString = \(String(describing: dict!["0"]))")
                
                let dict1 : Dictionary<String,String> = dict!["0"] as! Dictionary
                let vakues:String =    dict1["RESULTCODE"]!
                
               // let val=self.convertToDictionaryval(text: dict!["0"]!)
               
              print("responseString = \(String(describing: vakues))")
            }
            task.resume()
            
        }
    }
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func convertToDictionaryval(text: String) -> [String: String]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String : String]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self;
        GIDSignIn.sharedInstance().delegate = self ;
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        // Do any additional setup after loading the view, typically from a nib.
        signInButton.layer.borderWidth=0.5;
        signInButton.layer.cornerRadius = signInButton.frame.height / 3
        facebookSigninButton.layer.borderWidth=0.5;
          facebookSigninButton.layer.cornerRadius = signInButton.frame.height / 3
        manualLoginButton.layer.borderWidth=0.5;
          manualLoginButton.layer.cornerRadius = signInButton.frame.height / 3
        
        signInButton.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0);
          facebookSigninButton.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0);
          manualLoginButton.titleEdgeInsets = UIEdgeInsets(top: 15.0, left: 15.0, bottom: 15.0, right: 15.0);
    
    //    signInButton.layer.borderColor=UIColor( red: 0, green: 0, blue: 0, alpha: 0) as! CGColor;
        
        readPropertyList();
    }
    
    
//350752274119-e0tfagu345c3tbba39csh5kk45b7sa4o.apps.googleusercontent.com
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func readPropertyList(){
        
        let pathStr = Bundle.main.path(forResource: "serverdetails", ofType: "plist")
        let data :NSData? = NSData(contentsOfFile: pathStr!)
        let datasourceDictionary = try! PropertyListSerialization.propertyList(from: data! as Data, options: [], format: nil) as! [String:String]
        serverip = (datasourceDictionary["serverip"])!
      //   let  dandetest:String?  = (datasourceDictionary["dandetest"]).debugDescription
        print(datasourceDictionary.self)
        
        
        

    }

    func deviceName() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let str = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        return str
    }

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userMail: UILabel!
    @IBOutlet weak var emailID: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var facebookSigninButton: UIButton!
    @IBOutlet weak var manualLoginButton: UIButton!
    @IBOutlet weak var manualSignUp: UIButton!
    @IBOutlet weak var userImageref: UIImageView!
    
    @IBAction func googlePlusButtonTouchUpInside(_ sender: Any) {
      
        GIDSignIn.sharedInstance().signIn();
      //  let dande=AppDelegate();
       // dande.sign(<#T##signIn: GIDSignIn!##GIDSignIn?#>, didSignInFor: <#T##GIDGoogleUser?#>, withError: <#T##Error!#>);
        
    }
    
}

