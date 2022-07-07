//
//  APIError.swift
//  Quality Of Life
//
//  Created by Dan Mori on 05/07/22.
//

import Foundation

enum APIError: Error {
    case serverError
    case parsingError
    case internalError
}
