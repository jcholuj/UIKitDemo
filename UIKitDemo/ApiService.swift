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
        return Observable<T>.create { observer -> Disposable in
            let request = AF.request(urlRequest)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        if let data = response.data, let decodedData = try? decoder.decode(T.self, from: data) {
                            observer.onNext(decodedData)
                            observer.onCompleted()
                        } else {
                            observer.onError(ApiError.decodingError)
                        }
                    case .failure(let error):
                        if let code = response.response?.statusCode {
                            observer.onError(ApiError.httpError(code))
                        } else {
                            observer.onError(ApiError.unknown(error.localizedDescription))
                        }
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
