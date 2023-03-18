//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 14.03.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    private let coin : CoinModel?
    
    private let dataService : CoinImageService
    private var cancallables = Set<AnyCancellable>()
    
    init(coin: CoinModel) {
        self.coin = coin
        self.dataService = CoinImageService(coin: coin)
        addSubscribers()
        self.isLoading.toggle()

    }
    
    private func addSubscribers() {
        
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading.toggle()
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }.store(in: &cancallables)

    }
    
}
