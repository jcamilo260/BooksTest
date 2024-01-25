//
//  FetchDataService.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 24/01/24.
//

import Foundation
protocol FetchDataServiceProtocol{
    associatedtype FetchedData
    /// Takes action about the request and response of 'books'
    /// - Parameters:
    ///   - onSuccess: Completion that handles a positive result
    ///   - onFailure: Completion that handles a negative result
    /// - Returns: No return
    func fetchData(onSuccess: @escaping ([FetchedData])->Void, onFailure: @escaping (AuthenticationError)->Void) -> Void
}

class FetchDataService: FetchDataServiceProtocol, WebServiceURLProtocol{
    
    typealias FetchData = BookModel
    
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
        
    func fetchData(onSuccess: @escaping ([FetchData]) -> Void, onFailure: @escaping (AuthenticationError) -> Void) {
        var queryParameters: ServicesDatasource.queryParameter = ServicesDatasource.getAllBooksQuery.queryParameters
        guard let sessionKey = TokenHandler.getToken(serviceName: ServicesDatasource.SessionKeyQuery.serviceTokenName),
        let o_u = TokenHandler.getToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenNameSecondary) else {
            return
        }

        queryParameters[ServicesDatasource.Querykeys.sessionkey] = sessionKey
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
            
            if let booksResponse = JsonConverter.decodeData(data: data, type: BooksResponse.self){
                let bookModel: [BookModel] = booksResponse.allBooks.books.map { book in
                    BookModel(contactUC: book.contactUC?.rawValue, name: book.fpForm.name, image: book.ownerPrefs.oCoverImg)
                }
                onSuccess(bookModel)
            }
            else{
                onFailure(.unableToConvertData)
                return
            }
        }
        task.resume()
    }
}
