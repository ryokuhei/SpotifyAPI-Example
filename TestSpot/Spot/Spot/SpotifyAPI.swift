//
//  SpotifyAPI.swift
//  Spot
//
//  Created by ryoku on 2017/07/30.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import Alamofire

class SpotifyAPI {
    struct Authorization: SpotifyRequest {

        let clientId: String
        let responseType: String
        let redirectURI: URL

        var baseURL: URL {
           return URL(string: "https://accounts.spotify.com")!
        }
        var method: HTTPMethod {
            return .get
        }
        var path: String {
            return "authorize"
        }
        var parameters: Any? {
            let parameters: Parameters = [
                "client_id": clientId,
                "response_type": responseType,
                "redirect_uri": redirectURI,
            ]
            return parameters
        }
    }

    struct SearchItems: SpotifyRequest {

        enum ItemType: String {
            case album    = "album"
            case artist   = "artist"
            case track    = "track"
            case playlist = "playlist"
        }

        let keyword: String
        let itemType: ItemType
        let limit: Int?
        let ofset: Int?

        var method: HTTPMethod {
            return .get
        }

        var path: String {
            return "v1/search"
        }

        var parameters: Any? {
            var parameters: Parameters = [
                "q": keyword,
                "type": itemType,
            ]
            if let limit = self.limit {
                parameters.updateValue(limit, forKey: "limit")
            }

            if let ofset = self.ofset {
                parameters.updateValue(ofset, forKey: "ofset")
            }

            print(parameters)

            return parameters
        }

    }

}
