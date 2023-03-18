//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 13.03.2023.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var vm = HomeViewModel()
    
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]

    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView().statusBarHidden(true)
                    .preferredColorScheme(.dark)
               // CoinLogoView(coin: DeveloperPreview.instance.coin)
            }
                .environmentObject(vm)
        }
    }
}
