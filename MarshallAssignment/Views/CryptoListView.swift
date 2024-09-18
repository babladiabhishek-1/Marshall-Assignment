//
//  ContentView.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import SwiftUI

struct CryptoListView: View {
    @StateObject var viewModel: CryptoListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.cryptoData, id: \.symbol) { item in
                    NavigationLink(destination: CryptoDetailView(item: item, viewModel: viewModel)) {
                        HStack {
                            Image(systemName: "bitcoinsign.circle")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.blue)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text(item.baseAsset)
                                    .font(.headline)
                                Text("Last Price: \(viewModel.convertPrice(item.lastPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .navigationTitle("Crypto List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView(viewModel: viewModel)) {
                        Text("Settings")
                    }
                }
            }
            .task {
                await viewModel.fetchCryptoList()
            }
            
        }
        .errorAlert(errorMessage: $viewModel.errorMessage)
    }
}

#Preview {
    let networkManager = NetworkAPIManager.shared
    let exchangeRateManager = ExchangeRateManager()
    CryptoListView(viewModel: CryptoListViewModel(networkManager: networkManager, exchangeRateManager: exchangeRateManager))
}
