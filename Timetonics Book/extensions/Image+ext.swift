//
//  Image+ext.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import Foundation
import SwiftUI

extension Image{
    
    public func customImageSize()->some View{
        self.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50)
    }
    
    public func customSymbolSize()-> some View{
        self.customImageSize()
            .foregroundColor(.purple)
            .opacity(0.5)
    }
    
}
