//
//  LoginViewVM.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation

class LoginViewVM: ObservableObject {
    private var service: any AuthenticationServiceProtocol = AuthenticationService()
    
    @Published var email: String = "android.developer@timetonic.com"
    @Published var password: String = "Android.developer1"
    @Published var logedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    public func login() {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
            startLoginFlow()
        }
    }
    
    private func startLoginFlow() {
        resetLoginState()
        requestAppKey()
    }
    
    private func resetLoginState() {
        logedIn = false
        isLoading = true
        errorMessage = ""
    }
    
    private func requestAppKey() {
        service.requestCreateAppKey { [weak self] appkey in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                guard let appkeymodel = appkey as? AppkeyModel else {
                    self.handleLoginFailure(error: "Failed to retrieve App Key")
                    return
                }
                
                TokenHandler.saveToken(serviceName: ServicesDatasource.AppKeyQuery.serviceTokenName, token: appkeymodel.appkey)
                self.requestOAuthKey()
            }
        } onFailure: { [weak self] error in
            guard let self = self else { return }
            self.handleLoginFailure(error: error.rawValue)
        }
    }
    
    private func requestOAuthKey() {
        service.requestCreateOAuthKey(username: email, password: password) { [weak self] oauthkey in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                guard let oAuthModel = oauthkey as? OAuthModel else {
                    self.handleLoginFailure(error: "Failed to retrieve OAuth Key")
                    return
                }
                
                TokenHandler.saveToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenName, token: oAuthModel.oAuthKey)
                TokenHandler.saveToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenNameSecondary, token: oAuthModel.o_u)
                self.requestSessionKey()
            }
        } onFailure: { [weak self] error in
            guard let self = self else { return }
            self.handleLoginFailure(error: error.rawValue)
        }
    }
    
    private func requestSessionKey() {
        service.requestCreateSessionKey { [weak self] sessionKey in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                guard let sessionKeyModel = sessionKey as? SessionKeyModel else {
                    self.handleLoginFailure(error: "Failed to retrieve Session Key")
                    return
                }
                
                TokenHandler.saveToken(serviceName: ServicesDatasource.SessionKeyQuery.serviceTokenName, token: sessionKeyModel.sessionKey)
                self.handleSuccessfulLogin()
            }
        } onFailure: { [weak self] error in
            guard let self = self else { return }
            self.handleLoginFailure(error: error.rawValue)
        }
    }
    
    private func handleSuccessfulLogin() {
        logedIn = true
        email = ""
        password = ""
        isLoading = false
    }
    
    private func handleLoginFailure(error: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = error
        }
    }
}
