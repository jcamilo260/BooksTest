//
//  JsonConverter.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation
final class JsonConverter{
    
    /// Faster function in order to convert any data to a redeadle object
    /// - Parameters:
    ///   - data: data you want to decode
    ///   - type: generic type that you want to return
    /// - Returns: returns the converted object
    public static func decodeData<T: Decodable>(data: Data, type: T.Type)->T?{
        let jsonDecoder: JSONDecoder = JSONDecoder()
        let decoded = try? jsonDecoder.decode(type, from: data)
        guard let decoded = decoded else {return nil}
        return decoded
    }
    
}
