//
//  Text+ext.swift
//  Timetonics Book
//
//  Created by Juan Camilo Argüelles Ardila on 25/01/24.
//

import Foundation
import SwiftUI
extension Text{
    func customText( color: UIColor) -> some View {
        self.foregroundColor(Color(uiColor: color))
    }
}
