//
//  ApiClient.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 09/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct ApiClient {
    static let apiService = ApiService()
    
    static func fetchCharacters() -> Observable<[Character]> {
        return apiService.run(Endpoint.fetchCharacters)
    }
}
