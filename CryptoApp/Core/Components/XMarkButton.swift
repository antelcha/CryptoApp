//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 16.03.2023.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dissmis
    var body: some View {
        Button(action: {
            dissmis.callAsFunction()
        },label: {
            Image(systemName: "xmark")
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton()
    }
}
