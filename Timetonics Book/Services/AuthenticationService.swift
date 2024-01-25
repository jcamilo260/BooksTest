//
//  AuthenticationService.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import Foundation

protocol AuthenticationServiceProtocol{
    associatedtype Appkey
    associatedtype OAuthKey
    associatedtype SessionKey
    
    /// Takes action about the request and response of 'createKey'
    /// - Parameters:
    ///   - onSuccess: Completion that handles a positive result
    ///   - onFailure: Completion that handles a negative result
    /// - Returns: No return
    func requestCreateAppKey(onSuccess: @escaping (Appkey)->Void, onFailure: @escaping (AuthenticationError)->Void) -> Void
    /// Takes action about the request and response of 'sessionKey'
    /// - Parameters:
    ///   - onSuccess: Completion that handles a positive result
    ///   - onFailure: Completion that handles a negative result
    /// - Returns: No return
    func requestCreateSessionKey(onSuccess: @escaping (SessionKey)->Void, onFailure: @escaping (AuthenticationError)->Void) -> Void
    /// Takes action about the request and response of 'oAuthKey'
    /// - Parameters:
    ///   - onSuccess: Completion that handles a positive result
    ///   - onFailure: Completion that handles a negative result
    /// - Returns: No return
    func requestCreateOAuthKey(username: String, password: String, onSuccess: @escaping (OAuthKey)->Void, onFailure: @escaping (AuthenticationError)->Void) -> Void
}

class AuthenticationService: AuthenticationServiceProtocol, WebServiceURLProtocol{
    
    typealias OAuthKey = OAuthModel
    typealias Appkey = AppkeyModel
    typealias SessionKey = SessionKeyModel
    
    private var url: URL = URL(string: ServicesDatasource.baseUrl + ServicesDatasource.requestUrlExtension)!
    
    func getUrlRequest(url: URL) -> URLRequest {
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        return urlRequest
    }
    
    func getUrlWithQueryParameters(queryParameters: ServicesDatasource.queryParameter) -> URL? {
        var urlComponents: URLComponents = URLComponents(string: ServicesDatasource.baseUrl + ServicesDatasource.requestUrlExtension)!
        urlComponents.queryItems = queryParameters.map({
            URLQueryItem(name: $0.key, value: String(describing: $0.value))
        })
        guard let finalUrl = urlComponents.url else {
            return nil
        }
        return finalUrl
    }
  
    func requestCreateSessionKey(onSuccess: @escaping (SessionKeyModel) -> Void, onFailure: @escaping (AuthenticationError) -> Void) {
        var queryParameters: ServicesDatasource.queryParameter = ServicesDatasource.SessionKeyQuery.queryParameters
        guard let o_u = TokenHandler.getToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenNameSecondary),
              let oAuthKey = TokenHandler.getToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenName) else {
            return
        }

        queryParameters[ServicesDatasource.Querykeys.oauthkey] = oAuthKey
        queryParameters[ServicesDatasource.Querykeys.o_u] = o_u
        queryParameters[ServicesDatasource.Querykeys.u_c] = o_u
        
        
        let finalUrl: URL = getUrlWithQueryParameters(queryParameters: queryParameters)!
        let urlRequest = getUrlRequest(url: finalUrl)
        
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
            
            guard self != nil else {return}
            
            if error != nil{
                onFailure(.unableToPerformRequest)
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode != 200{
                onFailure(.unexpectedStatusCode)
                return
            }
            
            guard let data = data else{
                onFailure(.unexpectedNilData)
                return
            }
            
            if let sessionKeyResponse = JsonConverter.decodeData(data: data, type: SessionKeyResponse.self){
                let sessionKeyModel: SessionKey = SessionKeyModel(status: sessionKeyResponse.status, sessionKey: sessionKeyResponse.sessionKey, id: sessionKeyResponse.id, appName: sessionKeyResponse.appName, vnb: sessionKeyResponse.vnb, request: sessionKeyResponse.request)
                onSuccess(sessionKeyModel)
            }
            else{
                onFailure(.unableToConvertData)
                return
            }
        }
        task.resume()
        
    }
    
    func requestCreateOAuthKey(username: String, password: String, onSuccess: @escaping (OAuthModel) -> Void, onFailure: @escaping (AuthenticationError) -> Void) {
        var queryParameters: ServicesDatasource.queryParameter = ServicesDatasource.OAuthQuery.queryParameters
        guard let appkey = TokenHandler.getToken(serviceName: ServicesDatasource.AppKeyQuery.serviceTokenName) else{
            return
        }
        queryParameters[ServicesDatasource.Querykeys.appKey] = appkey
        queryParameters[ServicesDatasource.Querykeys.login] = username
        queryParameters[ServicesDatasource.Querykeys.password] = password
        
        let finalUrl: URL = getUrlWithQueryParameters(queryParameters: queryParameters)!
        let urlRequest = getUrlRequest(url: finalUrl)
        let task = URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
            
            guard self != nil else {return}
            
            if error != nil{
                onFailure(.unableToPerformRequest)
                return
            }
            
            if let response = response as? HTTPURLResponse,
               response.statusCode != 200{
                onFailure(.unexpectedStatusCode)
                return
            }
            
            guard let data = data else{
                onFailure(.unexpectedNilData)
                return
            }
            
            
            if let oAuthKeyResponse = JsonConverter.decodeData(data: data, type: OAuthKeyResponse.self){
                let oAuthModel: OAuthKey = OAuthModel(status: oAuthKeyResponse.status, oAuthKey: oAuthKeyResponse.oAuthKey, o_u: oAuthKeyResponse.o_u, request: oAuthKeyResponse.request)
                onSuccess(oAuthModel)
            }else{
                onFailure(.unableToConvertData)
                return
            }
        }
        task.resume()
    }
    
    func requestCreateAppKey(onSuccess: @escaping (AppkeyModel) -> Void, onFailure: @escaping (AuthenticationError) -> Void)->Void {
        let queryParameters: ServicesDatasource.queryParameter = ServicesDatasource.AppKeyQuery.queryParameters
        
        let finalUrl: URL = getUrlWithQueryParameters(queryParameters: queryParameters)!
        let urlRequest = getUrlRequest(url: finalUrl)
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, urlResponse, error in
            
            guard self != nil else {return}
            
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
                onSuccess(appkeyModel)
            }else{
                onFailure(.unableToConvertData)
                return
            }
        }
        task.resume()
    }
}
