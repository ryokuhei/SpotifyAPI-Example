//
//  AccessTokenAdapter.swift
//  Spot
//
//  Created by ryoku on 2017/07/22.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import Alamofire

class AccessTokenAdapter: RequestAdapter {

    private let accessToken: String

    init(accessToken: String) {
        self.accessToken = accessToken
    }

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let urlString = urlRequest.url?.absoluteString,
            urlString.hasPrefix("https://api.spotify.com") {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                urlRequest.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }

}
