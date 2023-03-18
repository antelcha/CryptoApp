//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 17.03.2023.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com")!
    let twitterURL = URL(string: "https://www.twitter.com/antelcha")!
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                aboutSection
                coinGeckoSection
                
            }
            .listStyle(.grouped)
            .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton(dissmis: _dismiss)
                    }
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


extension SettingsView {
    
    private var aboutSection : some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("This app was made by following a @SwiftulThinking course on Youtube!")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }.padding(.vertical)
            
            Link("Follow on twitter", destination: twitterURL)
            Link("Youtube", destination: youtubeURL)
            Link("Github", destination: defaultURL)
            
        } header: {
            Text("About app")
        }.tint(.blue)
    }
    
    private var coinGeckoSection : some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text("Crypto currency data that is used in this app comes from Coin Gecko! ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.theme.accent)
            }.padding(.vertical)
            
            Link("Coin Gecko", destination: twitterURL)
            
            
        } header: {
            Text("About app")
        }.tint(.blue)
    }
    
}
