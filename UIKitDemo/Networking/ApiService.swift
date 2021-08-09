//
//  ApiService.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 09/08/2021.
//

import Foundation
import RxSwift
import Alamofire

final class ApiService {
    
    func run<T: Codable>(_ urlRequest: URLRequestConvertible, _ decoder: JSONDecoder = JSONDecoder()) -> Observable<T> {
        // TODO: Implement api request and handle errors using ApiError
        return Observable.empty()
    }
}
