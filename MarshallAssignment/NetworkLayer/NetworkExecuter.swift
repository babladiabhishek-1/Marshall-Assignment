//
//  NetworkExecuter.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation
import Combine

//MARK: Generic URL Session to fetch Data

protocol HTTPRequestProtocol {
    func performRequest<T: Codable>(
        endpoint: EndPointTarget,
        responseModel: T.Type,
        cachedResponseOnError: Bool) async throws -> T
}

class HTTPRequestExecuter: HTTPRequestProtocol {
    
    var urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func performRequest<T: Codable>(
        endpoint: EndPointTarget,
        responseModel: T.Type,
        cachedResponseOnError: Bool) async throws -> T {
            
            guard let url = endpoint.getURL() else {
                throw NetworkError.badURL
            }
            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method.rawValue
            
            do {
                let (data, response) = try await urlSession.data(for: request)
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw NetworkError.noResponse
                }
                
                if 200..<400 ~= httpResponse.statusCode {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        return decodedData
                    } catch {
                        throw NetworkError.decodeFailed
                    }
                    
                } else {
                    if cachedResponseOnError {
                        if let cachedResponse = urlSession.configuration.urlCache?.cachedResponse(for: request) {
                            LoggerHelper.shared.log(data: data)
                            return try JSONDecoder().decode(T.self, from: cachedResponse.data)
                        } else {
                            throw NetworkError.serverError
                        }
                    } else {
                        throw NetworkError.serverError
                    }
                }
            } catch {
                LoggerHelper.shared.log(error: error)
                throw AppError(reason: error.localizedDescription, error: true)
            }
        }
}
