//
//  AppKeyResponse.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import Foundation

struct AppKeyResponse: Decodable{
    
    let status: String
    let appkey: String
    let id: String
    let vnb: String
    let request: String
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case appkey = "appkey"
        case id = "id"
        case vnb = "createdVNB"
        case request = "req"
    }
}
