//
//  userLogininfo.swift
//  MERCYDA TRACK
//
//  Created by Tony on 10/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

class UserLoginInfo:NSObject,NSCoding {
    
    let username:String?
    let password:String?
    
    init(_ usId: String?,pswd: String?){
        self.username = usId
        self.password = pswd
    }
    required convenience init (coder aDecoder: NSCoder) {
           let userName = aDecoder.decodeObject(forKey: userDefaultKeys.userName.rawValue) as? String ?? ""
           let passWord = aDecoder.decodeObject(forKey: userDefaultKeys.passWord.rawValue ) as? String ?? ""
        self.init(userName, pswd: passWord)
        
        
    }
    func encode(with aCoder: NSCoder) {
         aCoder.encode(userName, forKey:  userDefaultKeys.userName.rawValue)
         aCoder.encode(passWord, forKey: userDefaultKeys.passWord.rawValue)
    }
    func save() {
           
    let savedData = NSKeyedArchiver.archivedData(withRootObject: self)
    let defaults = UserDefaults.standard
           
    defaults.set(savedData, forKey: userDefaultKeys.userLoginInfo.rawValue)
           
    if !defaults.synchronize() {
        defaults.set(savedData, forKey: userDefaultKeys.userLoginInfo.rawValue)
        }
    }
       
       class func getUserInfo() -> UserLoginInfo? {
           
           let defaults = UserDefaults.standard
           if let userInfo = defaults.object(forKey:userDefaultKeys.userLoginInfo.rawValue)as? Data {
               
               return (NSKeyedUnarchiver.unarchiveObject(with:userInfo) as! UserLoginInfo)
               
           }
           else {
               return nil
           }
       }
       
}

