//
//  URLBuildable.swift
//  MERCYDA TRACK
//
//  Created by Jaiecom iOS Developer1 on 28/06/2020.
//  Copyright © 2020 Team Kochi Dev. All rights reserved.
//

import Foundation

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json        = "application/json"
    case urlEncoded  = "application/x-www-form-urlencoded; charset=utf-8"
    case appleWallet = "application/vnd.apple.pkpass"
    case urlEncodedHttpBody  = "application/x-www-form-urlencoded"
    case textHtml = "text/html"
    case textJavascript = "text/javascript"
    case basicAuthorization = "Basic amF6emx5OlFRc2cjUzNpYk42NkpaYSQ="

}

enum CompletionState {
    case success(response: Any)
    case failure(error: String)
}

enum NetworkError: Error {
    case emptyResponse
    case fullResponse
}

enum InvoiceValidationError: String, Error {
    case deliveryTypeNotFound = "TXT_PLEASE_SELECT_A_DELEIVERY_TYPE"
    case collectionTypeNotFound = "TXT_PLEASE_SELECT_A_COLLECTION_TYPE"
    case minimumStoreValueDoesnotMeetInvoiceValue = "TXT_MIN_INVOICE_AMOUNT_MSG"
    case invalidDeliveryType = "TXT_YOUR_SELECTED_DELEIVERY_TYPE_IS_INVALID"
}

import Foundation
import Alamofire

protocol URLBuildable: URLRequestConvertible {
    // HTTPMethod default is post
    var httpMethod: HTTPMethod {get}
    //API path for the request
    var path: String? {get}
    //Parameters
    var parameters: Parameters? {get}
    //Accept type in header
    var acceptType: ContentType {get}
}

extension URLBuildable {
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        var urlCopy = buildEnvironment.baseUrl
        if let pathCopy = path {
            let removeWhiteSpace = pathCopy.components(separatedBy: .whitespaces).joined()
            urlCopy += removeWhiteSpace
        }
        print(urlCopy)
        let url = try urlCopy.asURL()
        var urlRequest = URLRequest(url: url)
        // HTTP Method
        urlRequest.httpMethod = httpMethod.rawValue
        // Common Headers
        urlRequest.addValue(ContentType.basicAuthorization.rawValue, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
        urlRequest.addValue(acceptType.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        if let params = parameters {
            do {
                printLog(Utility.printJsonText(object: params))
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}
