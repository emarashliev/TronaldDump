//
//  File.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import Foundation
import SwiftyJSON

private let allTagsUrl = URL(string: "https://api.tronalddump.io/tag")!

struct Tag {
    var name: String
}

extension Tag {
    static let allTagsResource = Resource<[Tag]>(url: allTagsUrl, parseJSON: { json in
        return json.dictionaryValue["_embedded"]?.arrayValue.flatMap { tagJson in
            guard let name = tagJson.string else { return nil }
            let tag = Tag(name: name)
            return tag
        }
    })
}
