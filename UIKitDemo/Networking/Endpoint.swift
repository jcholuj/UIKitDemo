//
//  Endpoint.swift
//
//  Created by Jędrzej Chołuj on 16/07/2021.
//  Copyright © 2021 KISS digital. All rights reserved.
//

import Foundation
import Alamofire


enum Endpoint {
    case fetchCharacters
}

extension Endpoint: URLRequestConvertible {

    func asURLRequest() throws -> URLRequest {
        let encoding: ParameterEncoding = {
            switch httpMethod {
            default:
                return URLEncoding.default
            }
        }()
        let urlRequest = createRequest(url: baseUrl.appendingPathComponent(path))
        return try encoding.encode(urlRequest, with: nil)
    }
    
    
    private var apiDomain: String {
        return "https://thronesapi.com/"
    }
    
    private var baseUrl: URL {
        return URL(string: "\(apiDomain)api/v2/")!
    }
    
    private var path: String {
        switch self {
        default:
            return "Characters"
        }
    }
    
    private var httpMethod: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }
    
    private func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.httpMethod = httpMethod.rawValue
        return request
    }
}
