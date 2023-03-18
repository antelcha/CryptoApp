//
//  DetailView.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 17.03.2023.
//

import SwiftUI

struct DetailLoadingView : View {
    @Binding var  coin: CoinModel?

    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}


struct DetailView: View {
    
    @StateObject private var vm: DetailViewModel
    @State private var showFullDescription : Bool = false
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        
    ]
    let coin: CoinModel
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
        self.coin = coin

    }
    
    var body: some View {
        ScrollView {
            VStack {
                ChartView(coin: vm.coin).padding(.vertical)
                VStack(spacing: 20) {
                    
                    overviewTitle
                    Divider()
                    descriptionSection
                    overviewGrid
                    additionalTitle
                    Divider()
                    additionalGrid
                    websiteSection
                }
                .padding()
            }
            
        }.navigationTitle(vm.coin.name)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    navigationBarTrailingItems
                    
                }
            }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(coin: dev.coin)
        }
        
        
    }
}

extension DetailView {
    
    private var websiteSection : some View {
        HStack(alignment: .firstTextBaseline, spacing: 20) {
            if
                let websiteString = vm.websiteURL,
                let url = URL(string: websiteString) {
                Link("Website", destination: url)
            }
            
            if
                let redditString = vm.redditURL,
                let url = URL(string: redditString) {
                Link("Reddit", destination: url)
            }
            
        }.tint(.blue)
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.headline)
    }
    
    
    private var descriptionSection  : some View {
        ZStack {
            if let coinDescription = vm.coinDescription, !coinDescription.isEmpty {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? .none : 3)
                        .font(.callout)
                        .foregroundColor(.theme.secondaryText)
                    Button {
                        withAnimation(.easeInOut) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Read less..." : "Read more..")
                            .font(.caption)
                            .fontWeight(.bold)
                            .padding(.vertical, 4)
                    }.tint(.blue)

                }.frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    
    private var navigationBarTrailingItems : some View {
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(.theme.secondaryText)
            CoinImageView(coin: coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var overviewTitle : some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalTitle : some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundColor(.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid : some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []
        ) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }

    }
    
    private var additionalGrid : some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []
        ) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }

    }
    
}
