//
//  Test.swift
//  MarshallAssignmentTests
//
//  Created by Abhishek Babladi on 2024-09-17.
//

import Testing
import Combine

@Suite @MainActor
class CryptoListViewModelTests {
    let mockNetworkManager = MockNetworkAPIManager()
    let mockExchangeRateManager = MockExchangeRateManager()
    lazy var viewModel = CryptoListViewModel(networkManager: mockNetworkManager, exchangeRateManager: mockExchangeRateManager)
    var cancellables = Set<AnyCancellable>()
    let expectedInrToUsdRate: Double = 0.011928875274065909
    let expectedUsdToSekRate: Double = 10.2093
    
    @Test("Toggle Currency")
    func toggleCurrency() {
        // Given
        let initialCurrency = viewModel.isUSD
        
        // When
        viewModel.toggleCurrency()
        
        // Then
        #expect(viewModel.isUSD == !initialCurrency) // In this case SEK
    }
    
    @Test("Fetch Crypto List Success")
    func fetchCryptoListSuccess() async {
        // Given
        let expectedCryptoData = [CryptoData]()
        mockNetworkManager.cryptoDataList = expectedCryptoData
        
        // When
        await viewModel.fetchCryptoList()
        
        // Then
        #expect(viewModel.cryptoData == expectedCryptoData)
        #expect(viewModel.errorMessage == nil)
    }
    
    @Test("Fetch Crypto List Failure")
    func fetchCryptoListFailure() async {
        // Given
        mockNetworkManager.shouldFail = true
        
        // When
        await viewModel.fetchCryptoList()
        
        // Then
        #expect(viewModel.errorMessage != nil)
        #expect(viewModel.cryptoData.isEmpty)
    }
    
    @Test("Fetch Exchange Rates")
    func fetchExchangeRates() async {
        // When
        viewModel.fetchExchangeRates()
        
        // Then
        #expect(viewModel.inrToUsdRate == expectedInrToUsdRate)
        #expect(viewModel.usdToSekRate == expectedUsdToSekRate)
    }
    
    @Test("Convert Price to USD")
    func convertPriceToUSD() async {
        // Given
        viewModel.inrToUsdRate = 0.011928875274065909
        viewModel.isUSD = true
        
        // When
        let convertedPrice = viewModel.convertPrice("100")
        
        // Then
        #expect(convertedPrice == "1.19")
    }
    
    @Test("Convert Price to SEK")
    func convertPriceToSEK() async {
        // Given
        viewModel.inrToUsdRate = 0.011928875274065909
        viewModel.usdToSekRate = 10.2093
        viewModel.isUSD = false
        
        // When
        let convertedPrice = viewModel.convertPrice("100")
        
        // Then
        #expect(convertedPrice == "12.18")
    }
}
