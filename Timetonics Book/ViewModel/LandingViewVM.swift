//
//  LandingViewVM.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import Foundation

class LandingViewVM: ObservableObject {
    private var service: any FetchDataServiceProtocol = FetchDataService()
    @Published var books: [BookModel] = []
    
    /// Handles the request and response of bookModel
    /// - Returns: no return
    public func fetchData() -> Void {
        service.fetchData { [weak self] books in
            guard let self = self else { return }

            if let books = books as? [BookModel] {
                DispatchQueue.main.async {
                    self.books = books
                }
            }
        } onFailure: { error in
            print(error)
        }
    }
}

