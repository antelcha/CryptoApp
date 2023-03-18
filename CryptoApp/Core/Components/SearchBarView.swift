//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 15.03.2023.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchText : String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(
                    searchText.isEmpty ? .theme.secondaryText : .theme.accent
                )
            TextField("Search by name or symbol...", text: $searchText)
                .foregroundColor(.theme.accent)
                .autocorrectionDisabled(true)
                .overlay(alignment: .trailing) {
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x:10)
                        .opacity(searchText.isEmpty ? 0.0 : 1.0)
                        .foregroundColor(.theme.accent)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                     }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(
                    color: .theme.accent.opacity(0.15),
                    radius: 10, x: 0, y: 0)
        ).padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
    }
}
