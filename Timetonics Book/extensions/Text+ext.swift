//
//  Text+ext.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import Foundation
import SwiftUI
extension Text{
    /// Add behaviour of changinc color in a faster way
    /// - Parameter color: color you want for the text
    /// - Returns: returns the modified text
    func customText( color: UIColor) -> some View {
        self.foregroundColor(Color(uiColor: color))
    }
}
