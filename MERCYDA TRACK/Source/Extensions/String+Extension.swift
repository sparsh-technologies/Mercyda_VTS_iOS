//
//  String+Extension.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 30/06/20.
//  Copyright © 2020 Talish George. All rights reserved.
//

import UIKit

extension String {
    
    // MARK: - Properties

    var hex: Int? {
        return Int(self, radix: 16)
    }

    var insertBraces: String {
           String(format: "(%@)", self)
       }
    
    /// Return Capitalizing First Letter
    func capitalizingFirstLetter() -> String {
        prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    /// Return Upper Camel Cased
    func upperCamelCased() -> String? {
        self.lowercased()
            .split(separator: " ")
            .map { $0.lowercased().capitalizingFirstLetter() }
            .joined(separator: " ")
    }
    
    /// Return Lower Camel Cased
    func lowerCamelCased() -> String? {
        guard let upperCased = self.upperCamelCased() else {
            return nil
        }
        return upperCased.prefix(1).lowercased() + upperCased.dropFirst()
    }
    
    /// Prefix Image
    /// - Parameter imageName: String Type
    func prefixWithImage(_ imageName: String) -> NSMutableAttributedString? {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: imageName)
        let attributedStringwithImage = NSMutableAttributedString(attachment: imageAttachment)
        let attribuedString = NSAttributedString(string: String(format: "  %@", self))
        attributedStringwithImage.append(attribuedString)
        return attributedStringwithImage
    }
    
    /// Return Date Formatter as String
    /// - Parameter format: Date Format
    func formattedDateString(inFormat format: DateFormat) -> String {
        if let date = self.formattedDate() {
            let formatter = DateFormatter.formatter(with: format)
            return formatter.string(from: date)
        }
        return self
    }
    
    ///  Date Formatter
    /// - Parameters:
    ///   - format: date format
    ///   - withLocale: accepts date constants
    ///   - timeZone: accepts timezone
    func formattedDate(from format: DateFormat = .defaultFormat,
                       withLocale: Locale = Locale(identifier: DateConstants.locale),
                       timeZone: Timezone = .none) -> Date? {
        let formatter = DateFormatter.formatter(with: format,
                                                forLocale: withLocale,
                                                withZone: timeZone)
        return formatter.date(from: self)
    }
    
    /// Attributed String
    /// - Parameters:
    ///   - lineSpace: CGFloat
    ///   - fontName: UIFont
    ///   - textColor: UIColor
    ///   - isStrikethrough: Bool
    ///   - textAlignment: NSTextAlignment
    func attributedString(lineSpace: CGFloat,
                          font fontName: UIFont?,
                          color textColor: UIColor?,
                          isStrikethrough: Bool = false,
                          textAlignment: NSTextAlignment? = nil) -> NSAttributedString {
        var attributes = [NSAttributedString.Key: Any]()
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpace
        paragraphStyle.lineBreakMode = .byWordWrapping
        if let alignment = textAlignment {
            paragraphStyle.alignment = alignment
        }
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        attributes[NSAttributedString.Key.font] = fontName
        if isStrikethrough {
            attributes[NSAttributedString.Key.strikethroughStyle] = 2
            attributes[NSAttributedString.Key.strikethroughColor] = textColor
        }
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        return attributedString
    }
    
    /// Localized String
    func localized() -> String {
        let value = NSLocalizedString(self, comment: "")
        if value != self || NSLocale.preferredLanguages.first == "en" {
            return value
        }
        
        // Fall back to en
        guard
            let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
            let bundle = Bundle(path: path), !value.isEmpty
            else { return "" }
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }

    ///These subscripts help in accessing a substring easily, like xString[0...2] or xString[1..<3]
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }

    /// Variable to validate wether the all charactes are numeric
    var isNumeric: Bool {
        !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    /// Variable to validate wether the textfield only contains numeric values
    var numberFiltered: Bool {
        let characterSet = NSCharacterSet.alphanumerics.inverted
        let characterSetArray = self.components(separatedBy: characterSet)
        return self != characterSetArray.joined()
    }
    
    /// Get attributed string
    func getAttributedStringForAlignemnt() -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.lineBreakMode = NSLineBreakMode.byWordWrapping
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attrString.length))
        return attrString
    }
    
    var digits: String {
        components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var validated: String {
        self
    }
    
    /// Width of string based on font
    /// - Parameter font: UIFont
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
