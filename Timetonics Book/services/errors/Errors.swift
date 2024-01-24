//
//  Errors.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation

enum AuthenticationError:String, Error{
    case unableToPerformRequest = "Something went wrong"
    case unexpectedStatusCode = "We got a Server problem"
    case unexpectedNilData = "Problem with server comunication"
    case unableToConvertData = "check your credentials, try again please"
}

