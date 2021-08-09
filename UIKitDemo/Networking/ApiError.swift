//
//  ApiError.swift
//  UIKitDemo
//
//  Created by Jędrzej Chołuj on 09/08/2021.
//

import Foundation

enum ApiError: Error {
    case decodingError
    case httpError(Int)
    case unknown(String)
}
