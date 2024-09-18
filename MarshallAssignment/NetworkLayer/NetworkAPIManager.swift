//
//  NetworkAPIManager.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation
import Combine

//MARK: Network Manager to Fetch list of Cryptos and functions part of the protocol.

class NetworkAPIManager: NetworkAPIProtocol {
    
    var executer: HTTPRequestProtocol
    var exchangeRateManager: ExchangeRateManager
    
    init(executer: HTTPRequestProtocol, exchangeRateManager: ExchangeRateManager) {
        self.executer = executer
        self.exchangeRateManager = exchangeRateManager
    }
    
    static let shared = NetworkAPIManager(
        executer: HTTPRequestExecuter(),
        exchangeRateManager: ExchangeRateManager.shared
    )
    
    func fetchCryptoDataList() async throws -> [CryptoData] {
        do {
            let resultModel: [CryptoData]? = try await executer.performRequest(
                endpoint: ServiceEndPoint.fetchCryptoDataList,
                responseModel: [CryptoData].self,
                cachedResponseOnError: true
            )
            guard let cryptoList = resultModel else {
                return []
            }
            return cryptoList
        } catch {
            throw error
        }
    }
}
