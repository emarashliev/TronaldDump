//
//  Quote.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import Foundation

private func allQuotesUrl(tag: String) -> URL {
    let endcodedTag = tag.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    return URL(string: "https://api.tronalddump.io/tag/\(endcodedTag)")!
}

struct Quote {
    var quoteId: String
    var created: String
    var value: String
    var pritableText: String {
        get {
            return value.replacingOccurrences(of: "\\", with: "")
        }
    }
}

//I deliberately do not use Codable because the structure of the JSON is pretty inconsistent
//  and it is much more convenient to traversing it on that way
extension Quote {
    static func allQuotes(with tag: String) -> Resource<[Quote]> {
        return Resource<[Quote]>(url: allQuotesUrl(tag: tag), parseJSON: { json in
            return json.dictionaryValue["_embedded"]?
                .dictionaryValue["tags"]?.arrayValue.flatMap { tagJson in
                    guard let quoteId = tagJson["quote_id"].string,
                        let created =  tagJson["updated_at"].string,
                        let value = tagJson["value"].string else { return nil }
                    
                    let quote = Quote(quoteId: quoteId, created: created, value: value)
                    return quote
            }
        })
    }
}
