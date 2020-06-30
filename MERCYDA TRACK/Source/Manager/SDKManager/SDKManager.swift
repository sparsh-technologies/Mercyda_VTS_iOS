//
//  SDKInitializationService.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

class SDKManager {
    
    // MARK: - Properties
    
    static let shared = SDKManager()
    
    // MARK: - internal Methods
        
    /// Initilize ThemeManager
    func initilizeThemeManager() {
        ThemeManager.setup()
    }    
}
