//
//  CustomInputField.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import SwiftUI

enum InputType{
    case email
    case password
}

struct CustomInputField: View {
    let placeholder: String
    let inputType: InputType
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading){
            if self.text.isEmpty{
                Text(placeholder)
                    .foregroundColor(.gray)
            }
            if inputType == .email{
                TextField("", text: self.$text)
            }else{
                SecureField("", text: self.$text)
            }
        }
        .padding(.horizontal)
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color.init(uiColor: Datasource.Menu.buttonColor))
            .frame(height: 40))
    }
}

#Preview {
    CustomInputField(placeholder: "Email", inputType: .email, text: .constant(""))
}
