//
//  CryptoListViewmodel.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Combine
import SwiftUI

@MainActor
final class CryptoListViewModel: ObservableObject {
    @Published var cryptoData = [CryptoData]()
    @Published var errorMessage: String?
    @Published var isUSD: Bool = true
    @Published var inrToUsdRate: Double?
    @Published var usdToSekRate: Double?
    
    var networkManager: NetworkAPIManager
    var exchangeRateManager: ExchangeRateManager
    
    private var cancellables = Set<AnyCancellable>()
    
    init(networkManager: NetworkAPIManager, exchangeRateManager: ExchangeRateManager) {
        self.networkManager = networkManager
        self.exchangeRateManager = exchangeRateManager
        Task {
            await fetchCryptoList()
        }
        fetchExchangeRates()
    }
    
    func fetchCryptoList() async {
        do {
            let fetchedCryptoList = try await networkManager.fetchCryptoDataList()
            self.cryptoData = fetchedCryptoList
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    func fetchExchangeRates() {
        exchangeRateManager.fetchInrToUsdRate()
        exchangeRateManager.fetchUsdToSekRate()
        
        exchangeRateManager.$inrToUsd
            .combineLatest(exchangeRateManager.$usdToSek)
            .sink { [weak self] inrToUsd, usdToSek in
                self?.inrToUsdRate = inrToUsd
                self?.usdToSekRate = usdToSek
            }
            .store(in: &cancellables)
    }
    
    func convertPrice(_ price: String) -> String {
        guard let priceInInr = Double(price) else { return price }
        guard let inrToUsdRate = inrToUsdRate, let usdToSekRate = usdToSekRate else { return price }
        
        let priceInUsd = priceInInr * inrToUsdRate
        let convertedPrice = isUSD ? priceInUsd : priceInUsd * usdToSekRate
        return String(format: "%.2f", convertedPrice)
    }
    
    
    func toggleCurrency() {
        isUSD.toggle()
    }
}
