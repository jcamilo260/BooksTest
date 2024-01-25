//
//  LoginViewVM.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 23/01/24.
//

import Foundation
class LoginViewVM: ObservableObject{
    
    private var service: any AuthenticationServiceProtocol = AuthenticationService()
    public var email: String = "android.developer@timetonic.com"
    public var password: String = "Android.developer1"
    @Published var logedIn: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    /// Handles the interaction when login button is pressed in view
    /// - Returns: Just handles the data from the service
    public func login()->Void{
        self.logedIn = false
        self.isLoading = true
        self.errorMessage = ""
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return}
            self.service.requestCreateAppKey { appkey in
                guard let appkeymodel = appkey as? AppkeyModel else {self.isLoading = false; return}
                 TokenHandler.saveToken(serviceName: ServicesDatasource.AppKeyQuery.serviceTokenName, token: appkeymodel.appkey)
                 self.service.requestCreateOAuthKey(username: self.email, password:  self.password) { oauthkey in
                     guard let oAuthModel = oauthkey as? OAuthModel else {self.isLoading = false; return}
                     TokenHandler.saveToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenName, token: oAuthModel.oAuthKey)
                     TokenHandler.saveToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenNameSecondary, token: oAuthModel.o_u)
                     self.service.requestCreateSessionKey { sessionKey in
                         guard let sessionKeyModel = sessionKey as? SessionKeyModel else {self.isLoading = false; return}
                         TokenHandler.saveToken(serviceName: ServicesDatasource.SessionKeyQuery.serviceTokenName, token: sessionKeyModel.sessionKey)
                         self.logedIn = true
                         self.email = ""
                         self.password = ""
                         self.isLoading = false
                     } onFailure: { error in
                         self.handleLoginFailure(error: error.rawValue)
                     }

                 } onFailure: { error in
                     self.handleLoginFailure(error: error.rawValue)
                 }

                 
             } onFailure: { error in
                 self.handleLoginFailure(error: error.rawValue)
             }
        }
    }
    
    /// It's a faster way to set these values
    /// - Parameter error: error mesage that it's gonna be shown
    /// - Returns: no return
    private func handleLoginFailure(error: String? = nil)->Void {
        self.isLoading.toggle()
        self.errorMessage = error ?? "Unknown Error"
    }
    
}
