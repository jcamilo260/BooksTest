//
//  BooksData.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import Foundation

struct BookModel: Identifiable{
    var id: String{
        name + (image ?? "unknown") + (contactUC ?? "unknown")
    }
    var computedUrl: String{
        "\(ServicesDatasource.baseUrl)"
    }
    let contactUC: String?
    let name: String
    let image: String?
}
