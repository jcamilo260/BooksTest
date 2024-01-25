//
//  WebServiceURLProtocol.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 24/01/24.
//

import Foundation
protocol WebServiceURLProtocol{
    func getUrlRequest(url: URL)->URLRequest
    func getUrlWithQueryParameters(queryParameters: ServicesDatasource.queryParameter) -> URL?
}
