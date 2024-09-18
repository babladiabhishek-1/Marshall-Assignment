//
//  ExchangeResponse.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-16.
//

import Foundation

// MARK: - ExchangeRateResponse
struct ExchangeRateResponse: Codable {
    let centralBankCode: String
    let centralBankName: String
    let terms: String
    let privacy: String
    let from: String
    let amount: Double
    let timestamp: String
    let to: [ExchangeRate]
}

struct ExchangeRate: Codable {
    let quotecurrency: String
    let mid: Double
}
