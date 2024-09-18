//
//  MarshallAssignmentApp.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import SwiftUI

import SwiftUI

@main
struct MarshallAssignmentApp: App {
    var body: some Scene {
        WindowGroup {
            CryptoListView(viewModel: CryptoListViewModel(networkManager: NetworkAPIManager.shared, exchangeRateManager: ExchangeRateManager.shared))
        }
    }
}
