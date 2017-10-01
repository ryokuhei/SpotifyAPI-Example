//
//  StatusError.swift
//  Spot
//
//  Created by ryoku on 2017/08/01.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

enum StatusCood: Error {
    case ok
    case movedPermanently
    case found
    case badRequest
    case unauthorized
    case forbidden
    case notFind
    case internalServerError
    case serviceUnavailable

    /*
     * 1xx Informational
     * 2xx Success
     * 3xx Redirection
     * 4xx Client Error
     * 5xx Server Error
     */
    init?(StatusCood: Int) {
        switch StatusCood {
            case 200: self = .ok
            case 301: self = .movedPermanently
            case 302: self = .found
            case 400: self = .badRequest
            case 401: self = .unauthorized
            case 403: self = .forbidden
            case 404: self = .notFind
            case 503: self = .serviceUnavailable
        default: return nil
        }
    }
}
