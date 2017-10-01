//
//  SpotifyRequest.swift
//  Spot
//
//  Created by ryoku on 2017/07/30.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import Alamofire

protocol SpotifyRequest {

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters:Any? { get }

}

extension SpotifyRequest {
    var baseURL: URL {
        return URL(string: "https://api.spotify.com")!
    }

    func buildURL() -> URLComponents {

        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        if method == .get {
            let dictionary = parameters as? [String:Any]
            let queryItems = dictionary?.map { key, value in
                URLQueryItem(name: key, value: String(describing:value))
            }
            components?.queryItems = queryItems
        }

        return components!
    }

}
