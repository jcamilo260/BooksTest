//
//  LandingView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import SwiftUI

struct LandingView: View {
    @Environment(\.presentationMode) var presentationMode
    
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
            Spacer()
        }
    }
}

#Preview {
    LandingView()
}
