//
//  AuthenticationService.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import Foundation

enum AuthenticationError: Error{
    case unableToPerformRequest
    case unexpectedStatusCode
}

protocol AuthenticationServiceProtocol{
    associatedtype Appkey
    
    func getUrlRequest(url: URL)->URLRequest
    func requestCreateAppKey(onSuccess: @escaping (Appkey)->Void, onFailure: @escaping (AuthenticationError)->Void) -> Void
    func setQueryParameters(queryParameters: Datasource.ServicesData.queryParameter) -> URL?
}

class AuthenticationService: AuthenticationServiceProtocol
    
    typealias Appkey = AppKeyResponse
    private var url: URL = URL(string: Datasource.ServicesData.baseUrl)!
    
    func getUrlRequest(url: URL) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    
    func requestCreateAppKey(onSuccess: @escaping (AppKeyResponse) -> Void, onFailure: @escaping (AuthenticationError) -> Void)->Void {
        let queryParameters: Datasource.ServicesData.queryParameter = Datasource.ServicesData.AppKeyQuery.queryParameters
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = queryParameters.map { key, value in
            URLQueryItem(name: key, value: String(describing: value))
        }
        guard let finalUrl = components.url else {
            print("Query parameters has failed")
            return
        }
        var urlRequest = getUrlRequest(url: finalUrl)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error{
                onFailure(.unableToPerformRequest)
                return
            }
            
            if let response = urlResponse as? HTTPURLResponse, response.statusCode != 200{
                onFailure(.unableToPerformRequest)
                return
            }
            
    }
    
}
