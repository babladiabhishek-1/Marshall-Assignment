//
//  ModelData.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

//MARK: https://api.wazirx.com/sapi/v1/tickers/24hr Response

import Foundation
struct CryptoData: Codable,Equatable {
    let symbol: String
    let baseAsset: String
    let quoteAsset: String
    let openPrice: String
    let lowPrice: String
    let highPrice: String
    let lastPrice: String
    let volume: String
    let bidPrice: String
    let askPrice: String
    let at: Int
}
