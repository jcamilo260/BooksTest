//
//  Datasource.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import Foundation
import UIKit

struct Datasource{
    
    struct Menu{
        public static let textColor: UIColor = UIColor(red: 3/255, green: 3/255, blue: 3/255, alpha: 1)
        public static let buttonColor: UIColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    }
    
    struct AnimationData{
        
        enum AnimationPhases: CaseIterable{
            case begin
            case middle
            case final
            
            public var scaleForInputField: Double{
                switch self{
                case .begin:
                    return 1
                case .middle:
                    return 1.1
                case .final:
                    return 1
                }
            }
        }
        
    }
    
    struct ServicesData{
        public static let baseUrl: String = "https://timetonic.com/live/api.php"
        
        struct AppKeyQuery{
            public static let version: String = "version"
            public static let request: String = "req"
            public static let appName: String = "appname"
        }
        
        struct OAuthQuery{
            public static let version: String = "version"
            public static let request: String = "req"
            public static let login: String = "login"
            public static let password: String = "pwd"
            public static let appKey: String = "appkey"
        }
        
        struct SessionKeyQuery{
            public static let version: String = "version"
            public static let request: String = "req"
            public static let login: String = "login"
            public static let password: String = "pwd"
            public static let appKey: String = "appkey"
        }

    }
}
