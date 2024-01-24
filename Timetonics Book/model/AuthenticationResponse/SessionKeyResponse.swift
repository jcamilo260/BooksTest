//
//  SessionKeyResponse.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation

struct SessionKeyResponse: Decodable{
    let status: String
    let sessionKey: String
    let id: String
    let appName: String
    let vnb: String
    let request: String
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case sessionKey = "sesskey"
        case id = "id"
        case appName = "appName"
        case vnb = "createdVNB"
        case request = "req"
    }
}

struct SessionKeyModel{
    let status: String
    let sessionKey: String
    let id: String
    let appName: String
    let vnb: String
    let request: String
}
