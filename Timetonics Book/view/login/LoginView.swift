//
//  LoginView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import SwiftUI

extension Binding: Equatable where Value: Equatable {
    public static func ==(lhs: Binding<Value>, rhs: Binding<Value>) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}


struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var didLogin = false

    var body: some View {
        VStack {
            Spacer(minLength: 100)
            
            VStack(spacing: 35) {
                header
                inputSection
                Spacer()
                footerLogin
            }
        }
    }
    
    var header: some View {
        VStack(spacing: 35) {
            customText("Welcome", color: MenuDatasource.textColor)
                .font(.system(size: 40, weight: .heavy))
            customText("Access your account securely and easily.", color: MenuDatasource.textColor)
                .font(.system(size: 18))
        }
    }
    
    var inputSection: some View {
        VStack(spacing: 10) {
            customInputTextField(isEmail: true, text: self.$email)
            customInputTextField(isEmail: false, text: self.$password)
        }
        .frame(maxWidth: 350)
    }

    var footerLogin: some View {
        VStack {
            Image("LoginBookPicture")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            Button(action: { self.login() }) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color(uiColor: MenuDatasource.buttonColor))
                    .frame(width: 300, height: 80)
                    .overlay {
                        customText("Login", color: MenuDatasource.textColor)
                            .font(.system(size: 30, weight: .medium))
                    }
            }
        }
    }

    @ViewBuilder
    func customText(_ text: String, color: UIColor) -> some View {
        Text(text)
            .foregroundColor(Color(uiColor: color))
    }

    @ViewBuilder
    func customInputTextField(isEmail: Bool, text: Binding<String>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(isEmail ? "Email" : "Password")
                    .foregroundColor(.gray)
            }
            if isEmail{
                TextField("", text: text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }else{
                SecureField("", text: text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(Color(uiColor: MenuDatasource.buttonColor))
            .frame(height: 40))
    }

    private func login() {
        print("email: \(email)\n password: \(password)")
        email = ""
        password = ""
    }
}
    
    #Preview {
        LoginView()
    }
