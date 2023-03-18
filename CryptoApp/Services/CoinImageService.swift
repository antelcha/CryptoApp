//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Mustafa Girgin on 14.03.2023.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService {
    
    @Published var image : UIImage? = nil
    private var imageSubscription : AnyCancellable?
    private let coin : CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName : String
    
    
    init(coin : CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
        
    }
    
    private func getCoinImage() {
        
        if let savedImage =  fileManager.getImage(imageName: coin.id, folderName: folderName) {
            self.image = savedImage
        }
        else {
            downloadCoinImage()
            
        }
        
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else {return}
        
        imageSubscription = NetworkingManager.download(url: url)
            .tryMap({ (data) -> UIImage in
                if data == nil {return UIImage(systemName: "questionmark")!}
                return UIImage(data: data) ?? UIImage(systemName: "questionmark")!;
                
            }
            
            )
            .sink(receiveCompletion: NetworkingManager.handleCompletion(completion:), receiveValue: { [weak self] returnedImage in
                
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
                self?.fileManager.saveImage(image: returnedImage, imageName: self!.imageName, folderName: self!.folderName)
            }
            )
            
    }
}
