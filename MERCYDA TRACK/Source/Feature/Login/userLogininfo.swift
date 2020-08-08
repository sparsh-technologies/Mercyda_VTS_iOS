//
//  userLogininfo.swift
//  MERCYDA TRACK
//
//  Created by Tony on 10/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

class UserLoginInfo:NSObject,NSCoding {
    
    /// MARK: - Properties
    let username:String?
    let password:String?
    let isLoggedIn:Bool?
    init(_ usId: String?,pswd: String?,isLogedIn:Bool){
        self.username = usId
        self.password = pswd
        self.isLoggedIn = isLogedIn
    }
    required convenience init (coder aDecoder: NSCoder) {
        let userName = aDecoder.decodeObject(forKey: userDefaultKeys.userName.rawValue) as? String ?? ""
        let passWord = aDecoder.decodeObject(forKey: userDefaultKeys.passWord.rawValue ) as? String ?? ""
        let isLogin =  aDecoder.decodeObject(forKey: userDefaultKeys.isLogin.rawValue ) as? Bool ?? false
        
        self.init(userName, pswd: passWord,isLogedIn:isLogin)
        
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uame, forKey:  userDefaultKeys.userName.rawValue)
        aCoder.encode(passWord, forKey: userDefaultKeys.passWord.rawValue)
        aCoder.encode(isLoggedIn, forKey: userDefaultKeys.isLogin.rawValue)
    }
    
    
    /// Function for saving userdetails in preference
    func save() {
        
        let savedData = NSKeyedArchiver.archivedData(withRootObject: self)
        let defaults = UserDefaults.standard
        
        defaults.set(savedData, forKey: userDefaultKeys.userLoginInfo.rawValue)
        
        if !defaults.synchronize() {
            defaults.set(savedData, forKey: userDefaultKeys.userLoginInfo.rawValue)
        }
    }
    
    
    /// Function for getting userDetails from preferance
    class func getUserInfo() -> UserLoginInfo? {
        
        let defaults = UserDefaults.standard
        if let userInfo = defaults.object(forKey:userDefaultKeys.userLoginInfo.rawValue)as? Data {
            
            return (NSKeyedUnarchiver.unarchiveObject(with:userInfo) as! UserLoginInfo)
            
        }
        else {
            return nil
        }
    }
    
    
    /// function for clearing preferance data
    class func flushData() {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey:  userDefaultKeys.userLoginInfo.rawValue)
        
        if  !defaults.synchronize() {
            UserLoginInfo.flushData()
        }
    }
    
}

