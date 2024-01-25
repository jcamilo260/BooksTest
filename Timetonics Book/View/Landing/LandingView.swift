//
//  LandingView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var landingVM: LandingViewVM = LandingViewVM()
    @State private var isFiltering: Bool = false
    
    private var filteredBooks: [BookModel] {
        landingVM.books.filter { book in
            !isFiltering || book.contactUC != nil
        }
    }
    
    var headerSection: some View{
        VStack{
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    HStack {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                        Text("Log Out")
                            .foregroundColor(.black)
                            .fontWeight(.black)
                    }
                }
                .padding()
                
                Spacer()
            }
            
            Toggle(isOn: self.$isFiltering) {
                Text("Filter books")
            }
            .padding()
            
            VStack {
                Text("Books")
                    .customText(color: .black)
                    .font(.system(size: 70))
                    .fontWidth(.standard)
                    .fontWeight(.heavy)
                
                if self.filteredBooks.isEmpty{
                    VStack {
                        Image(systemName: "exclamationmark.warninglight")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("It seems to be empty here")
                            .customText(color: .black)
                            .font(.system(size: 20, weight: .medium))
                    }
                    
                }
            }
        }
    }
    
    var booksListSection: some View{
        List(self.filteredBooks) { book in
            BookCellView(book: book)
        }
    }
    
    var body: some View {
        VStack {
            headerSection
            Spacer()
            booksListSection
        }
        .onAppear(perform: {
            self.landingVM.fetchData()
        })
    }
}


#Preview {
    LandingView()
}
