//
//  Error.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation

struct AppError: Error, LocalizedError {

    let reason: String
    let error: Bool

    var errorDescription: String? {
        reason
    }
}

// MARK: - NetworkError
enum NetworkError: Error {
    case badURL
    case invalidJSON
    case serverError
    case noResponse
    case generalError
    case decodeFailed
    case notFound
}
