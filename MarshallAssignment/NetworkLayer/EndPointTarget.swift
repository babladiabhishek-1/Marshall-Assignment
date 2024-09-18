//
//  EndPointTarget.swift
//  MarshallAssignment
//
//  Created by Abhishek Babladi on 2024-09-13.
//

import Foundation

protocol EndPointTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    func getURL() -> URL?
}

extension EndPointTarget {
    func getURL() -> URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = baseURL
        component.path = path
        component.queryItems = queryItems
    
        let url = component.url        
        return url
    }
}

enum HTTPMethod: String {
    case get = "GET"
}

