//
//  SettingsView.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-14.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel: CryptoListViewModel

    var body: some View {
        VStack {
            Spacer()
            LottieView(loopMode: .loop, name: "bitcoin")
                .scaleEffect(0.5)
                .frame(width: 10, height: 10)
            Spacer()
            Toggle(isOn: $viewModel.isUSD) {
                Text("Display Prices in USD")
            }
            .padding()
            .onChange(of: viewModel.isUSD) { 
                viewModel.toggleCurrency()
            }
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    let exchangeRateManager = ExchangeRateManager()
    SettingsView(viewModel: CryptoListViewModel(networkManager: NetworkAPIManager.shared, exchangeRateManager: exchangeRateManager))
}
