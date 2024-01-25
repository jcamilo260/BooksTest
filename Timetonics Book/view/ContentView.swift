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
    }
}

#Preview {
    ContentView()
}
