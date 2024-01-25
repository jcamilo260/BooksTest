//
//  OAuthKeyResponse.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation

struct OAuthKeyResponse: Decodable{
    
    let status: String
    let oAuthKey: String
    let id: String
    let o_u: String
    let vnb: String
    let request: String
    
    enum CodingKeys: String, CodingKey{
        case status = "status"
        case oAuthKey = "oauthkey"
        case id = "id"
        case o_u = "o_u"
        case vnb = "createdVNB"
        case request = "req"
    }
}
