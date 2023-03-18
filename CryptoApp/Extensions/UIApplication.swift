//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 15.03.2023.
//

import Foundation
import SwiftUI
extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
