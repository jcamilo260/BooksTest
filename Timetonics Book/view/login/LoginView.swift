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
    @State private var didTapEmailTextField = false
    @State private var didTapPasswordTextField = false
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
            customText("Welcome", color: Datasource.Menu.textColor)
                .font(.system(size: 40, weight: .heavy))
            customText("Access your account securely and easily.", color: Datasource.Menu.textColor)
                .font(.system(size: 18))
        }
    }
    
    var inputSection: some View {
        VStack(spacing: 50) {
            customInputTextField("Email", text: $email, isFirstResponder: $didTapEmailTextField)
                .padding(.horizontal)
            customInputTextField("Password", text: $password, isFirstResponder: $didTapPasswordTextField)
                .padding(.horizontal)
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
                    .fill(Color(uiColor: Datasource.Menu.buttonColor))
                    .frame(width: 300, height: 80)
                    .overlay {
                        customText("Login", color: Datasource.Menu.textColor)
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
    func customInputTextField(_ placeholder: String, text: Binding<String>, isFirstResponder: Binding<Bool>) -> some View {
        ZStack(alignment: .leading) {
            if text.wrappedValue.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
            }
            TextField("", text: text, onEditingChanged: { editing in
                isFirstResponder.wrappedValue = editing
            })
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20)
            .fill(Color(uiColor: Datasource.Menu.buttonColor))
            .frame(height: 40))
        .phaseAnimator(Datasource.AnimationData.AnimationPhases.allCases, trigger: isFirstResponder) { view, phase in
            view.scaleEffect(phase.scaleForInputField)
                .onTapGesture {
                    isFirstResponder.wrappedValue.toggle()
                }
        }
    }

    private func login() {
        email = ""
        password = ""
    }
}
    
    #Preview {
        LoginView()
    }
