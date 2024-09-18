//
//  MockManager.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-17.
//

import Combine
import Foundation

// MARK: MockManager to Mock Network Requests

class MockHTTPRequestExecuter: HTTPRequestProtocol {
    var mockResponse: Any?
    var shouldThrowError: Bool = false
    
    func performRequest<T>(endpoint: any EndPointTarget, responseModel: T.Type, cachedResponseOnError: Bool) async throws -> T where T: Decodable, T: Encodable {
        if shouldThrowError {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        guard let response = mockResponse as? T else {
            throw NSError(domain: "TestError", code: 2, userInfo: nil)
        }
        return response
    }
}

class MockExchangeRateManager: ExchangeRateManager {
    var mockInrToUsdRate: Double = 0.011928875274065909
    var mockUsdToSekRate: Double = 10.2093
    var shouldThrowError: Bool = false
    
    override func fetchInrToUsdRate() {
        if shouldThrowError {
            self.errorMessage = NetworkError.noResponse
        } else {
            self.inrToUsd = mockInrToUsdRate
        }
    }
    
    override func fetchUsdToSekRate() {
        if shouldThrowError {
            self.errorMessage = NetworkError.noResponse
        } else {
            self.usdToSek = mockUsdToSekRate
        }
    }
    
    override func fetchExchangeRate(endpoint: ServiceEndPoint) -> AnyPublisher<Double, NetworkError> {
        if shouldThrowError {
            return Fail(error: NetworkError.noResponse).eraseToAnyPublisher()
        } else {
            let rate: Double
            switch endpoint {
            case .fetchInrToUsdRate:
                rate = mockInrToUsdRate
            case .fetchUsdToSekRate:
                rate = mockUsdToSekRate
            default:
                rate = 1.0
            }
            return Just(rate).setFailureType(to: NetworkError.self).eraseToAnyPublisher()
        }
    }
}

class MockNetworkAPIManager: NetworkAPIManager {
    var cryptoDataList: [CryptoData]
    var exchangeRate: Double
    var shouldFail: Bool
    
    init(cryptoDataList: [CryptoData] = [], exchangeRate: Double = 1.0, shouldFail: Bool = false) {
        self.cryptoDataList = cryptoDataList
        self.exchangeRate = exchangeRate
        self.shouldFail = shouldFail
        let mockExecuter = MockHTTPRequestExecuter()
        let mockExchangeRateManager = MockExchangeRateManager()
        super.init(executer: mockExecuter, exchangeRateManager: mockExchangeRateManager)
    }
    
    override func fetchCryptoDataList() async throws -> [CryptoData] {
        if shouldFail {
            throw NSError(domain: "TestError", code: 1, userInfo: nil)
        }
        return cryptoDataList
    }
    
     func fetchExchangeRates() -> AnyPublisher<Double?, Never> {
        if shouldFail {
            return Just(nil).eraseToAnyPublisher()
        } else {
            return Just(exchangeRate).eraseToAnyPublisher()
        }
    }
}
