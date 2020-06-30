//
//  Dictionary+Extension.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import Foundation

extension Dictionary {
    
    subscript(keyPath keyPath: String) -> Any? {
        get {
            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath)
                else { return nil }
            return getValue(forKeyPath: keyPath)
        }
        set {
            guard let keyPath = Dictionary.keyPathKeys(forKeyPath: keyPath),
                let newValue = newValue else { return }
            self.setValue(newValue, forKeyPath: keyPath)
        }
    }
    
    /// Get Keys
    /// - Parameter forKeyPath: String Type
    static private func keyPathKeys(forKeyPath: String) -> [Key]? {
        let keys = forKeyPath.components(separatedBy: ".")
                             .reversed()
                             .compactMap({ $0 as? Key })
        return keys.isEmpty ? nil : keys
    }
    
    // recursively (attempt to) access queried subdictionaries
    // (keyPath will never be empty here; the explicit unwrapping is safe)
    
    /// Recursively (attempt to) access queried subdictionaries
    /// - Parameter keyPath: Key
    private func getValue(forKeyPath keyPath: [Key]) -> Any? {
        guard let value = self[keyPath.last!] else { return nil }
        return keyPath.count == 1 ? value : (value as? [Key: Any])
            .flatMap { $0.getValue(forKeyPath: Array(keyPath.dropLast())) }
    }
    
    // recursively (attempt to) access the queried subdictionaries to
    // finally replace the "inner value", given that the key path is valid
    
    /// Recursively (attempt to) access the queried subdictionaries
    /// - Parameters:
    ///   - value: Any
    ///   - keyPath: Key
    private mutating func setValue(_ value: Any, forKeyPath keyPath: [Key]) {
        guard self[keyPath.last!] != nil else { return }
        if keyPath.count == 1 {
            (value as? Value).map { self[keyPath.last!] = $0 }
        } else if var subDict = self[keyPath.last!] as? [Key: Value] {
            subDict.setValue(value, forKeyPath: Array(keyPath.dropLast()))
            (subDict as? Value).map { self[keyPath.last!] = $0 }
        }
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    
    // MARK: - Properties
    var errors: [[String: Any]]? {
        return self["_errors"] as? [[String: Any]]
    }
    
    var jsonString: String {
        do {
            guard let stringData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) else { return "" }
            if let string = String(data: stringData, encoding: .utf8) {
                return string
            }
            return ""
        }
    }
}
