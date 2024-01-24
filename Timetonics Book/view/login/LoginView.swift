//
//  LoginView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import SwiftUI


struct LoginView: View {
    
    @StateObject var loginVM: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 35) {
                header
                inputSection
                footerLogin
            }
        }.fullScreenCover(isPresented: self.$loginVM.logedIn,  content: {
            LandingView()
        })
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
            customInputTextField(isEmail: true, text: self.$loginVM.email)
            customInputTextField(isEmail: false, text: self.$loginVM.password)
        }
        .frame(maxWidth: 350)
    }
    
    var footerLogin: some View {
        VStack {
            if !self.loginVM.errorMessage.isEmpty{
                customText(self.loginVM.errorMessage, color: .black)
                    .font(.footnote)
                    .fontWeight(.bold)
            }
            if self.loginVM.isLoading{
                ProgressView("Wait please")
            }
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
        VStack(alignment: .leading) {
            
            if isEmail{
                TextField("Email", text: text)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
            }else{
                SecureField("Password", text: text)
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
        self.loginVM.login()
    }
}

#Preview {
    LoginView()
}
