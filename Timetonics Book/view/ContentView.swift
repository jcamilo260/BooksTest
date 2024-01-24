//
//  ContentView.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 22/01/24.
//

import SwiftUI

struct ContentView: View {
    let service: any AuthenticationServiceProtocol = AuthenticationService()
    
    var body: some View {
        LoginView()
            .onAppear(perform: {
                service.requestCreateAppKey { appkey in
                    guard let appkeymodel = appkey as? AppkeyModel else {return}
                    TokenHandler.saveToken(serviceName: ServicesDatasource.AppKeyQuery.serviceTokenName, token: appkeymodel.appkey)
                    
                    service.requestCreateOAuthKey(username: "android.developer@timetonic.com", password:  "Android.developer1") { oauthkey in
                    
                        guard let oAuthModel = oauthkey as? OAuthModel else {return}
                        TokenHandler.saveToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenName, token: oAuthModel.oAuthKey)
                        TokenHandler.saveToken(serviceName: ServicesDatasource.OAuthQuery.serviceTokenNameSecondary, token: oAuthModel.o_u)
                                                
                                                
                        service.requestCreateSessionKey { sessionKey in
                            guard let sessionKeyModel = sessionKey as? SessionKeyModel else {return}
                            TokenHandler.saveToken(serviceName: ServicesDatasource.SessionKeyQuery.serviceTokenName, token: sessionKeyModel.sessionKey)
                        } onFailure: { error in
                            print(error)
                        }

                    } onFailure: { error in
                        print(error)
                    }

                    
                } onFailure: { error in
                    print(error)
                }
                
            })
    }
}

#Preview {
    ContentView()
}
