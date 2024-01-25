//
//  BookCellView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import SwiftUI

struct BookCellView: View {
    
    let book: BookModel
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: ServicesDatasource.baseUrl+(book.image ?? ""))) { asyncImagePhase in
                switch asyncImagePhase{
                case .success(let image):
                    image.customImageSize()
                        .aspectRatio(contentMode: .fit)
                case .failure(_):
                    Image(systemName: "ladybug")
                        .customSymbolSize()
                case .empty:
                    EmptyView()
                @unknown default:
                    Image(systemName: "ant.circle.fill")
                        .customSymbolSize()
                }
            }.clipShape(Circle())
            
            Spacer()
            
            Text("\(book.name)")
                .customText(color: .black)
                .font(.system(size: 20, weight: .medium))
                .multilineTextAlignment(.trailing)
        }
    }
}

#Preview {
    BookCellView(book: BookModel(contactUC: "", name: "lo que sea", image: "imagehere"))
}
