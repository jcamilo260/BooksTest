//
//  WebServiceURLProtocol.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 24/01/24.
//

import Foundation
protocol WebServiceURLProtocol{
    
    /// Generates url request in a faster way
    /// - Parameter url: the base url
    /// - Returns: returns urlRequest with httpMethod
    func getUrlRequest(url: URL)->URLRequest
    
    /// Generates a URL with query parameters
    /// - Parameter queryParameters: parameters that will be added in the base url
    /// - Returns: url that contains query parameters
    func getUrlWithQueryParameters(queryParameters: ServicesDatasource.queryParameter) -> URL?
}
