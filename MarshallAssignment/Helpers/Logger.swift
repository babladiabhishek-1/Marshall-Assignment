//
//  Logger.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation
import OSLog

protocol LogNetworkProtocol {
    func log(_ response: HTTPURLResponse?, data: Data?, error: Error?, HTTPMethod: String?)
}

final class LoggerHelper: LogNetworkProtocol {
    
    static let shared = LoggerHelper()
    let ENABLELOG = true
    private let logger = Logger(subsystem: "com.umain.MarshallAssignment", category: "Network")
    
    func log(_ response: HTTPURLResponse? = nil, data: Data? = nil, error: Error? = nil, HTTPMethod: String? = nil) {
        guard ENABLELOG else { return }
        
        logger.log(level: .info, "========== Start logResponse ========== ")
        
        defer {
            logger.log(level: .info, "========== End logResponse ========== ")
        }
        
        guard let response = response else {
            logger.error("❌ NULL Response ERROR: ❌")
            return
        }
        
        if let url = response.url?.absoluteString {
            logger.log(level: .info, "Request URL: \(url, privacy: .public)")
            logger.log(level: .info, "Response CallBack Status Code: \(response.statusCode, privacy: .public)")
        } else {
            logger.error("❌ LOG ERROR: ❌: Empty URL")
        }
        
        if let method = HTTPMethod {
            logger.log(level: .info, "Request HTTPMethod: \(method, privacy: .public)")
        }
        
        if let error = error {
            logger.error("❌ GOT URL REQUEST ERROR: ❌: \(error.localizedDescription, privacy: .public)")
        }
        
        guard let data = data else {
            logger.error("❌ Empty Response ERROR: ❌")
            return
        }
        
        logger.log(level: .info, "✅ Response CallBack Data: ✅")
        if let json = data.prettyPrintedJSONString {
            logger.log(level: .info, "\(json, privacy: .public)")
        } else {
            let responseDataString: String = String(data: data, encoding: .utf8) ?? "BAD ENCODING"
            logger.log(level: .info, "\(responseDataString, privacy: .public)")
        }
    }
}
