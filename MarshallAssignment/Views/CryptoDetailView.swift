//
//  CryptoDetailView.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-14.
//

import SwiftUI

struct CryptoDetailView: View {
    let item: CryptoData
    @StateObject var viewModel: CryptoListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Symbol: \(item.symbol)")
                .font(.headline)
            Text("Base Asset: \(item.baseAsset)")
            Text("Quote Asset: \(item.quoteAsset)")
            Text("Open Price: \(viewModel.convertPrice(item.openPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
            Text("Low Price: \(viewModel.convertPrice(item.lowPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
            Text("High Price: \(viewModel.convertPrice(item.highPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
            Text("Last Price: \(viewModel.convertPrice(item.lastPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
            Text("Volume: \(item.volume)")
            Text("Bid Price: \(viewModel.convertPrice(item.bidPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
            Text("Ask Price: \(viewModel.convertPrice(item.askPrice)) \(viewModel.isUSD ? "USD" : "SEK")")
            Spacer()
            Text("\(Date(timeIntervalSince1970: TimeInterval(item.at / 1000)))")
        }
        .padding()
        .navigationTitle(item.baseAsset)
    }
}
