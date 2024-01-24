//
//  ServiceDatasource.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation

protocol WebserviceQuery{
    static var serviceTokenName: String {get set}
    static var queryParameters: ServicesDatasource.queryParameter { get set}
}

struct ServicesDatasource{
    
    public typealias queryParameter = [String:Any]
    public static let baseUrl: String = "https://timetonic.com/live/api.php"
    
    struct Querykeys{
        public static let version: String = "version"
        public static let request: String = "req"
        public static let login: String = "login"
        public static let password: String = "pwd"
        public static let appKey: String = "appkey"
        public static let appName: String = "appname"
        public static let o_u: String = "o_u"
        public static let u_c: String = "u_c"
        public static let oauthkey: String = "oauthkey"
    }
    
    struct AppKeyQuery: WebserviceQuery{
        static var serviceTokenName: String = "tokenAppKey"
        static var queryParameters: ServicesDatasource.queryParameter = [
            Querykeys.version: "1.47",
            Querykeys.request: "createAppkey",
            Querykeys.appName: "BooksApp"
        ]
    }
    
    struct OAuthQuery: WebserviceQuery{
        static var serviceTokenName: String = "tokenOAuthKey"
        static var serviceTokenNameSecondary: String = "tokenOAuthKey_o_u"
        public static var queryParameters: queryParameter = [
            Querykeys.version: "1.47",
            Querykeys.request : "createOauthkey",
            Querykeys.login: "",
            Querykeys.password: "",
            Querykeys.appKey: ""
        ]
    }
    
    struct SessionKeyQuery: WebserviceQuery{
        static var serviceTokenName: String = "tokenSessionKey"
        public static var queryParameters: queryParameter = [
            Querykeys.version: "1.47",
            Querykeys.request : "createSesskey",
            Querykeys.o_u: "",
            Querykeys.u_c: "",
            Querykeys.oauthkey: ""
        ]
    }
}
