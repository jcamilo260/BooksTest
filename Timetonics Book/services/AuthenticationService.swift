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
    case unexpectedNilData
}

protocol AuthenticationServiceProtocol{
    associatedtype Appkey
    
    func getUrlRequest(url: URL)->URLRequest
    func requestCreateAppKey(onSuccess: @escaping (Appkey)->Void, onFailure: @escaping (AuthenticationError)->Void) -> Void
    func setQueryParameters(queryParameters: Datasource.ServicesData.queryParameter) -> URL?
}

class AuthenticationService: AuthenticationServiceProtocol{

    typealias Appkey = AppkeyModel
    private var url: URL = URL(string: Datasource.ServicesData.baseUrl)!
    
    func getUrlRequest(url: URL) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    
    func setQueryParameters(queryParameters: Datasource.ServicesData.queryParameter) -> URL? {
        var urlComponents: URLComponents = URLComponents(string: Datasource.ServicesData.baseUrl)!
        urlComponents.queryItems = queryParameters.map({
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        })
        guard let finalUrl = urlComponents.url else {
            return nil
        }
        return finalUrl
    }
    
    func requestCreateAppKey(onSuccess: @escaping (AppkeyModel) -> Void, onFailure: @escaping (AuthenticationError) -> Void)->Void {
        let queryParameters: Datasource.ServicesData.queryParameter = Datasource.ServicesData.AppKeyQuery.queryParameters
        
        let finalUrl: URL = setQueryParameters(queryParameters: queryParameters)!
        let urlRequest = getUrlRequest(url: finalUrl)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, urlResponse, error in
            
            guard let self = self else {return}
            
            if error != nil{
                onFailure(.unableToPerformRequest)
                return
            }
            
            if let response = urlResponse as? HTTPURLResponse, response.statusCode != 200{
                onFailure(.unableToPerformRequest)
                return
            }
            
            guard let data = data else {
                onFailure(.unexpectedNilData)
                return
            }
            
            if let appkeyResponse = JsonConverter.decodeData(data: data, type: AppKeyResponse.self){
                let appkeyModel: AppkeyModel = AppkeyModel(id: appkeyResponse.id, status: appkeyResponse.status, appkey: appkeyResponse.appkey, request: appkeyResponse.request)
                print(appkeyModel)
            }
            
            
            
        }
        task.resume()
    }
}
