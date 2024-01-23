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
                    print(appkey)
                } onFailure: { error in
                    print(error)
                }

            })
    }
}

#Preview {
    ContentView()
}
