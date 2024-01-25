//
//  BooksResponse.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 24/01/24.
//

import Foundation

// MARK: - BooksData
struct BooksResponse: Codable {
    let allBooks: AllBooks
}

// MARK: - AllBooks
struct AllBooks: Codable {
    let books: [Book]
}

// MARK: - Book
struct Book: Codable {
    let contactUC: BO?
    let fpForm: FPForm
    let ownerPrefs: OwnerPrefs
    let contactConfirmed: Bool?

    enum CodingKeys: String, CodingKey {
        case contactUC = "contact_u_c"
        case fpForm, ownerPrefs, contactConfirmed
    }
}

enum BO: String, Codable {
    case demo = "demo"
    case mkuil = "mkuil"
    case uu = "uu"
}

// MARK: - FPForm
struct FPForm: Codable {
    let name: String
}

// MARK: - OwnerPrefs
struct OwnerPrefs: Codable {
    let oCoverImg: String?
}
