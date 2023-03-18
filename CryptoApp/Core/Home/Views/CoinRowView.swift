//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 13.03.2023.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin : CoinModel
    let showHoldingsColumn : Bool
    
    var body: some View {
        HStack(){
            leftColumn
            Spacer()
            if (showHoldingsColumn) {centerColumn}
            rightColumn
            
        }.font(.subheadline)
            .background(Color.theme.background.opacity(0.001))
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin, showHoldingsColumn: true )
    }
}


extension CoinRowView {
    private var leftColumn : some View {
        HStack(spacing: 0){
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)
        }
    }
    
    private var centerColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }.foregroundColor(.theme.accent)
        
    }
    
    private var rightColumn : some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith2Decimals())
                .bold()
                .foregroundColor(.theme.accent)
            Text(coin.priceChangePercentage24H?.asPercentageString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0 ) < 0.00 ?
                        .theme.red :
                        .theme.green
                )
        }
    }
    
}

