//
//  APIService.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation
//MARK: Utilized Builder to build api endpoints
enum ServiceEndPoint {
    case fetchCryptoDataList
    case fetchInrToUsdRate
    case fetchUsdToSekRate
}

extension ServiceEndPoint: EndPointTarget {
    var path: String {
        switch self {
        case .fetchCryptoDataList:
            return "/sapi/v1/tickers/24hr"
        case .fetchInrToUsdRate:
            return "/v1/central_bank_rate"
        case .fetchUsdToSekRate:
            return "/v1/central_bank_rate"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchCryptoDataList:
            return nil
        case .fetchInrToUsdRate:
            return [
                URLQueryItem(name: "central_bank", value: "IND"),
                URLQueryItem(name: "to", value: "USD"),
                URLQueryItem(name: "amount", value: "1"),
                URLQueryItem(name: "inverse", value: "false"),
                URLQueryItem(name: "decimal_places", value: "20"),
                URLQueryItem(name: "margin", value: "0"),
                URLQueryItem(name: "fields", value: "mid")
            ]
        case .fetchUsdToSekRate:
            return [
                URLQueryItem(name: "central_bank", value: "USA"),
                URLQueryItem(name: "to", value: "SEK"),
                URLQueryItem(name: "amount", value: "1"),
                URLQueryItem(name: "inverse", value: "false"),
                URLQueryItem(name: "decimal_places", value: "20"),
                URLQueryItem(name: "margin", value: "0"),
                URLQueryItem(name: "fields", value: "mid")
            ]
        }
    }

    var baseURL: String {
        switch self {
        case .fetchCryptoDataList:
            return "api.wazirx.com"
        case .fetchInrToUsdRate, .fetchUsdToSekRate:
            return "xecdapi.xe.com"
        }
    }

    var method: HTTPMethod {
        return .get
    }
}
