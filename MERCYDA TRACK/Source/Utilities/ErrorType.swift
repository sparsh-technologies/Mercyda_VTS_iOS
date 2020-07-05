//
//  ErrorType.swift
//  MERCYDA TRACK
//
//  Created by Vinod on 04/07/20.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

enum AppSpecificError: String, Error {
    case unknownError = "Unknown Error"
    case responseValidationError = "Response Validation not Available"
    case resultFieldMissingError = "Result Field Missing"
    case errorFieldMissingError = "Error Field Missing"
}
