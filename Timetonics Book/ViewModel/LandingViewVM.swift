//
//  LandingViewVM.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import Foundation
class LandingViewVM: ObservableObject{
    private var service: any FetchDataServiceProtocol = FetchDataService()
    @Published var books: [BookModel] = []
    
    public func fetchData()->Void{
        self.service.fetchData { books in
            if let books = books as? [BookModel]{
                self.books = books
            }
        } onFailure: { error in
            print(error)
        }

    }
}
