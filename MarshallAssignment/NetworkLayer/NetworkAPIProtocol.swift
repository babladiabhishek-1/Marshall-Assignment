//
//  NetworkAPIProtocol.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation
import Combine

//MARK: Protocol for NetworkAPIManager

protocol NetworkAPIProtocol {
    func fetchCryptoDataList() async throws -> [CryptoData]
}
