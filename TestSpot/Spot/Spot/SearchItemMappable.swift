//
//  SpotifyJSONMappable.swift
//  Spot
//
//  Created by ryoku on 2017/07/29.
//  Copyright © 2017 ryoku. All rights reserved.
//

import Foundation
import ObjectMapper

class SearchItemMappable: Mappable {

    var tracks: Track?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        tracks <- map["tracks"]
    }
}

class Track: Mappable {

    var items: [Item]?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        items <- map["items"]
    }
}

class Item: Mappable {

    var album: Album?
    var name: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        album <- map["album"]
        name   <- map["name"]
    }
}

class Album: Mappable {
    var images: [Image]?
    var artists: [Artist]?

    required init?(map: Map) {
    }
    func mapping(map: Map) {
        images   <- map["images"]
        artists   <- map["artists"]
    }
}

class Image: Mappable {
    var hight: Int?
    var width: Int?
    var url: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        hight <- map["hight"]
        width <- map["width"]
        url   <- map["url"]
    }
}

class Artist: Mappable {

    var name: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        name   <- map["name"]
    }

}
