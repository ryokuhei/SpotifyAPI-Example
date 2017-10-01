//
//  HTTPMethod.swift
//  Spot
//
//  Created by ryoku on 2017/07/30.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case head    = "HEAD"
    case delete  = "DELETE"
    case patch   = "PATCH"
    case options = "OPTIONS"
    case connect = "CONNECT"
}
