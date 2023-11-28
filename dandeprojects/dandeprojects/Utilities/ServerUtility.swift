//
//  ServerUtility.swift
//  dandeprojects
//
//  Created by dande reddyprasad on 14/04/18.
//  Copyright © 2018 dande reddyprasad. All rights reserved.
//

import UIKit

class ServerUtility {
  var serverip:String = "";
func getServerIP() -> String{
    
    let pathStr = Bundle.main.path(forResource: "serverdetails", ofType: "plist")
    let data :NSData? = NSData(contentsOfFile: pathStr!)
    let datasourceDictionary = try! PropertyListSerialization.propertyList(from: data! as Data, options: [], format: nil) as! [String:String]
    serverip = (datasourceDictionary["serverip"])!
    //   let  dandetest:String?  = (datasourceDictionary["dandetest"]).debugDescription
    print(datasourceDictionary.self)
    
    
    return serverip
    
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
    func hexStringToUIColor (hex:String,alp:Float) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(alp)
        )
    }
    
}
