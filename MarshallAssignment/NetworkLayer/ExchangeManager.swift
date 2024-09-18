//
//  ExchangeManager.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-16.
//


import Foundation
import Combine

//MARK: Exchange rate API Fetched from Xe to calculate USD

class ExchangeRateManager: ObservableObject {
    @Published var inrToUsd: Double?
    @Published var usdToSek: Double?
    @Published var errorMessage: NetworkError?
    
    private var cancellables = Set<AnyCancellable>()
    
    static let shared = ExchangeRateManager()
    
    func fetchInrToUsdRate() {
        fetchExchangeRate(endpoint: .fetchInrToUsdRate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = NetworkError.noResponse
                case .finished:
                    break
                }
            }, receiveValue: { rate in
                self.inrToUsd = rate
            })
            .store(in: &cancellables)
    }
    
    func fetchUsdToSekRate() {
        fetchExchangeRate(endpoint: .fetchUsdToSekRate)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = NetworkError.noResponse
                case .finished:
                    break
                }
            }, receiveValue: { rate in
                self.usdToSek = rate
            })
            .store(in: &cancellables)
    }
    
    func fetchExchangeRate(endpoint: ServiceEndPoint) -> AnyPublisher<Double, NetworkError> {
        let accountID = ".187643310"
        let apiKey = "mgcst02ddljs9l3r9r34q6l8s2"
        
        guard let url = endpoint.getURL() else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        let authValue = "Basic \((accountID + ":" + apiKey).data(using: .utf8)!.base64EncodedString())"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: ExchangeRateResponse.self, decoder: JSONDecoder())
            .map { response in
                response.to.first?.mid ?? 0.0
            }
            .mapError { _ in NetworkError.noResponse }
            .eraseToAnyPublisher()
    }
}
