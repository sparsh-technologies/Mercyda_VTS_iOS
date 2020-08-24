//
//  Utility.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import UIKit
import SDWebImage

typealias Latlon = (lat : Double, lon : Double)
class Utility: NSObject {
    
    class func errorTextFiled(_ textField: UITextField,addBorder:Bool = true)  {
        textField.placeHolderColor = UIColor.red //UIColor(red: 0.702, green: 0.165, blue: 0.467, alpha: 1.00)
           if addBorder{
              // textField.textFieldBorderColor = UIColor.red //UIColor(red: 0.702, green: 0.165, blue: 0.467, alpha: 1.00)
              // textField.borderWidth = 2
            textField.addBottomborder(color: UIColor.red)
           }
       }
    
  
}

extension Utility {
    class func printJsonText(object: Any) -> String {
        if let theJSONData = try? JSONSerialization.data(withJSONObject: object,
                                                         options: .prettyPrinted),
            let theJSONText = String(data: theJSONData,
                                     encoding: String.Encoding.ascii) {
            return ("JSON string = \n\(theJSONText)")
        }
        return ("JSON string = Error")
    }
    
    
    
     class  func topMostController() -> UIViewController {
           var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
           while (topController.presentedViewController != nil) {
               topController = topController.presentedViewController!
           }
           return topController
           
       }
    
   class func getDate(unixdateinMilliSeconds: Int) -> String {
    
            let convertToOriginalTimestamp = unixdateinMilliSeconds/1000
            let timeStamp = Double(convertToOriginalTimestamp)
            if timeStamp == 0 {return ""}
            let date = NSDate(timeIntervalSince1970: timeStamp)
  
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm a"
           // dayTimePeriodFormatter.dateFormat = "dd/mm/YYYY hh:mm a"
            dayTimePeriodFormatter.timeZone = .current
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            return dateString

        }
    
    class func getDateFromTimeStamp(sourceDate:Int) -> Date{
                let timeStamp = Double(sourceDate)
                let date = NSDate(timeIntervalSince1970: timeStamp)
               let dayTimePeriodFormatter = DateFormatter()
               dayTimePeriodFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
               dayTimePeriodFormatter.timeZone = .current
               return date as Date
    }
    
    
    class func getUserName() -> String {
           if let loginData = UserLoginInfo.getUserInfo(){
            printLog(loginData.username!)
            return "\(loginData.username!)"
           }
           return "No usernameName"
       }
    
    class func getPassword() -> String{
        if let loginData = UserLoginInfo.getUserInfo(){
              printLog(loginData.password!)
                   return "\(loginData.password!)"
                  }
        return "No password"
    }
    
    class func getTimeOnly(unixdateinMilliSeconds: Int) -> String {
      
              let convertToOriginalTimestamp = unixdateinMilliSeconds/1000
              let timeStamp = Double(convertToOriginalTimestamp)
              if timeStamp == 0 {return ""}
              let date = NSDate(timeIntervalSince1970: timeStamp)
    
              let dayTimePeriodFormatter = DateFormatter()
              dayTimePeriodFormatter.dateFormat = "hh:mm a"
             // dayTimePeriodFormatter.dateFormat = "dd/mm/YYYY hh:mm a"
              dayTimePeriodFormatter.timeZone = .current
              let dateString = dayTimePeriodFormatter.string(from: date as Date)
              return dateString

          }
    
    
  class  func hexStringToUIColor (_ hex:String) -> UIColor
       {
           var cString:String = hex.trimmingCharacters(in: (NSCharacterSet.whitespacesAndNewlines as NSCharacterSet) as CharacterSet).uppercased()
           if (cString.hasPrefix("#"))
           {
               cString.remove(at: cString.startIndex)
               
           }
           
           if ((cString.count) != 6)
           {
               return UIColor.gray
           }
           
           var rgbValue:UInt32 = 0
           Scanner(string: cString).scanHexInt32(&rgbValue)
           
           return UIColor(
               red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
               green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
               blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
               alpha: CGFloat(1.0)
           )
       }
       
 class func getTimeStampForAPI(flag: Int) -> String {
        
        let startDateFormatter = DateFormatter()
        startDateFormatter.dateFormat = "yyyy-MM-dd"
        let now = NSDate()
        let currentYear = startDateFormatter.string(from: now as Date)
        let dateString = "00:00:00 " + currentYear
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm:ss yyyy-MM-dd"
        let s = dateFormatter.date(from: dateString)
        let startDate = s!.timeIntervalSince1970 * 1000
        let endDate = NSDate().timeIntervalSince1970 * 1000
        
        if flag == 1 {
            return String(Int(startDate))
        }
        if flag == 2 {
            return String(Int(endDate))
        }
        return ""
    }
}


