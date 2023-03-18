//
//  HomeView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 13.03.2023.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm : HomeViewModel
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioView : Bool = false
    @State private var showSettingsView : Bool = false
    @State private var selectedCoin : CoinModel? = nil
    @State private var showDetailView : Bool = false
    
    
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView(searchText: $vm.searchText)
                        .environmentObject(vm)
                }
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                columnTitles
                
                
                if(!showPortfolio) {
                    allCoinsList
                        .listStyle(.plain)
                        .transition(.move(edge: .leading))
                    
                }
                
                if(showPortfolio) {
                    portfolioCoinsList
                        .listStyle(.plain)
                        .transition(.move(edge: .trailing))
                    
                }
                
                 
                Spacer()
            }.sheet(isPresented: $showSettingsView) {
                SettingsView()
            }
            
            
        }.background(
            NavigationLink(destination: DetailLoadingView(coin: $selectedCoin), isActive: $showDetailView, label: {
                EmptyView()
            })
            )
    }
    
    private var allCoinsList: some View {
        
            List {
                ForEach(vm.allCoins) { coin in
                    
                    
                    CoinRowView(coin: coin, showHoldingsColumn: false)
                        .onTapGesture {
                            segue(coin: coin)
                        }
                }
            }.refreshable {
                vm.reloadData()
                
            }
        }
        
    
    private func segue(coin: CoinModel) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(vm.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .onTapGesture {
                        segue(coin: coin)
                    }
            }
        }.id(UUID())
            .refreshable {
                vm.reloadData()
            }
        
    }

    
    private var columnTitles : some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .rank || vm.sortOption == .rankReversed) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .rank ? 0: 180))
            }.onTapGesture {
                withAnimation(.default) {
                    vm.sortOption = vm.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            Spacer()
            if (showPortfolio){
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down").opacity((vm.sortOption == .holdings || vm.sortOption == .holdingsReversed) ? 1.0 : 0.0)
                        .rotationEffect(Angle(degrees: vm.sortOption == .holdings ? 0: 180))
                }.onTapGesture {
                    withAnimation(.default){
                        vm.sortOption = vm.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
                
            }
            
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((vm.sortOption == .price || vm.sortOption == .price) ? 1.0 : 0.0)
                    .rotationEffect(Angle(degrees: vm.sortOption == .price ? 0: 180))
            }.onTapGesture {
                withAnimation(.default){
                    vm.sortOption = vm.sortOption == .price ? .priceReversed : .price
                }
            }
            
            
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }.font(.caption)
            .foregroundColor(.theme.secondaryText)
            .padding(.horizontal, 20)
            
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView{
                HomeView()
            }.statusBarHidden(true)
                .environmentObject(dev.homeVM)
        }
    
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    
                    if(showPortfolio) {
                        showPortfolioView.toggle()
                    } else {
                        showSettingsView.toggle()
                    }
                }
                .background(
                CircleButtonAnimationView(animate: $showPortfolio))
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .animation(.none)
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0 ))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                    
                }
        }
        .padding(.horizontal)
    }
}
