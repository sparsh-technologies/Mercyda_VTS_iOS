//
//  NSObjectExtension.swift
//  TestProjectApp
//
//  Created by Tony on 08/04/20.
//  Copyright © 2020 Tony. All rights reserved.
//

import Foundation

public protocol ClassNameProtocol {
    static var className: String { get }
}

public extension ClassNameProtocol {
     static var className: String {
        return String(describing: self)
    }
}

extension NSObject: ClassNameProtocol {}
