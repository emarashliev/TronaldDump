//
//  Resource.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Resource<T> {
    var url: URL
    var parse: (Data) -> T?
}

extension Resource {
    init(url: URL, parseJSON:  @escaping (JSON) -> T?) {
        self.url = url
        self.parse = { data in
            let json = try? JSON(data: data)
            return json.flatMap(parseJSON)
        }
    }
}
