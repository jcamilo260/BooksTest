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
    @State var isFiltering: Bool = false
    private var filteredBooks: [BookModel]{
        return landingVM.books.filter { book in
            !isFiltering || book.contactUC != nil
        }
    }
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {presentationMode.wrappedValue.dismiss()}, label: {
                    
                    HStack {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                        Text("Log Out")
                            .foregroundColor(.black)
                            .fontWeight(.black)
                    }
                })
                .padding()
                
                Spacer()
            }
            VStack{
                Text("Books").customText(color: .black)
                    .font(.system(size: 70))
                    .fontWidth(.standard)
                    .fontWeight(.heavy)
                
                List(self.filteredBooks){book in
                    
                    HStack {
                        Text("\(book.name)")
                    }
                    
                }
            }
            Spacer()
        }.onAppear(perform: {
            self.landingVM.fetchData()  
        })
    }
}

#Preview {
    LandingView()
}
