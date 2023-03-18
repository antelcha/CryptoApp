//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 16.03.2023.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm : HomeViewModel
    @Binding var searchText : String
    @State private var selectedCoin : CoinModel? = nil
    @State private var quantityText : String = ""
    @State private var showCheckmark : Bool = false
    

    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $searchText)
                    coinLogoList
                    if selectedCoin != nil {portfolioInputSection}
                    
                }.animation(.none)
                    .font(.headline)
            }.navigationTitle("Edit portfolio")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        XMarkButton(
                        dissmis: _dismiss)
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailingNavBarButtons
                    }
                    
                }.onChange(of: vm.searchText) { value in
                    if value == "" {
                        removeSelectedCoin()
                    }
                    
                }
        }
    }
    
    
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView(searchText: .constant(""))
    }
}


extension PortfolioView {
    private var coinLogoList : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(searchText.isEmpty ? vm.portfolioCoins : vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75, height: 110)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.2)) {
                                
                                
                                if(selectedCoin?.id == coin.id) {
                                    selectedCoin = nil
                                } else {
                                    selectedCoin = coin
                                }
                                updateSelectedCoin(coin: coin)
                                
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(selectedCoin?.id == coin.id ? .theme.green.opacity(0.10) : .theme.accent.opacity(0.05) )
                        
                            
                        )
                }
            }.padding(.leading)
        }
    }
    
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = vm.portfolioCoins.first(where: {$0.id == coin.id}),
           let amount = portfolioCoin.currentHoldings
        {
            quantityText = "\(amount)"
            
        }
        else {
            quantityText = ""
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0;
    }
    
    private var portfolioInputSection  : some View {
        
            
            VStack(spacing: 20) {
                HStack {
                    Text("Current price of \(selectedCoin!.symbol.uppercased()):")
                    Spacer()
                    Text(selectedCoin!.currentPrice.asCurrencyWith2Decimals())
                }
                Divider()
                HStack {
                    Text("Amount holding: ")
                    Spacer()
                    TextField("Ex: 1.4", text: $quantityText)
                        .multilineTextAlignment(.trailing)
                        .keyboardType(.decimalPad)
                }
                
                Divider()
                HStack {
                    Text("Current value: ")
                    Spacer()
                    Text(getCurrentValue().asCurrencyWith2Decimals())
                    
                }
                
            }.padding()
            
        
    }
    
    private var trailingNavBarButtons : some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark").opacity(showCheckmark ? 1 : 0)
            
            Button(action: {
                saveButtonPressed()
                
            },
            label: {Text("Save".uppercased())}
            )
        }
        .padding(4)
        .font(.headline)
        .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
    }
    
    
    private func saveButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else {return}
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        withAnimation(.easeIn) {
            showCheckmark = true
            removeSelectedCoin()
            
        }
        UIApplication.shared.endEditing()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            withAnimation(.easeOut) {
                showCheckmark = false
            }
        })
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        vm.searchText = ""
    }
    
}
