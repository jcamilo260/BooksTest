//
//  LoginView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var didLogin: Bool = false
    
    var body: some View {
        VStack{
            
            Spacer(minLength: 100)
            
            VStack(spacing: 35) {
                customText(text: "Welcome", color: Datasource.Menu.textColor)
                    .font(.system(size: 40, weight: .heavy))
                
                
                customText(text: "Access your account securely and easily.", color: Datasource.Menu.textColor)
                    .font(.system(size: 18))
                
                VStack(spacing: 50) {
                    ZStack(alignment: .leading){
                        if self.email.isEmpty{
                            Text("Email")
                                .foregroundColor(.gray)
                        }
                        TextField("", text: self.$email)
                    }
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.init(uiColor: Datasource.Menu.buttonColor))
                        .frame(height: 40))
                    
                    ZStack(alignment: .leading){
                        if self.password.isEmpty{
                            Text("Password")
                                .foregroundColor(.gray)
                        }
                        SecureField("", text: self.$password)
                    }
                    .padding(.horizontal)
                    .background(RoundedRectangle(cornerRadius: 15)
                        .fill(Color.init(uiColor: Datasource.Menu.buttonColor))
                        .frame(height: 40))
                }
                .padding(.horizontal, 40.0)
            }
            
            Spacer()
            
            
            Image("LoginBookPicture")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            Spacer()
            
            Button(action: {self.login()}, label: {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.init(uiColor: Datasource.Menu.buttonColor))
                    .frame(width: 300, height: 80)
                    .overlay {
                        customText(text: "Login", color: Datasource.Menu.textColor)
                            .font(.system(size: 30, weight: .medium))
                            
                    }
            })
        }
    }
    
    @ViewBuilder
    func customText(text: String, color: UIColor) -> some View{
        Text(text)
            .foregroundColor(Color(uiColor: color))
    }
    
    private func login(){
        print("email: \(self.email)\n password: \(self.password)")
    }
}

#Preview {
    LoginView()
}
