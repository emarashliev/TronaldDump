//
//  Webservice.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import Foundation

final class Webservice {
        
    init() { }
    
    /// Loads a resource. The completion handler is always called on the main queue.
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T>) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, _ in
            let parsed = data.flatMap(resource.parse)
            let result = Result(parsed, or: WebserviceError.other)
            mainQueue { completion(result) }
            }.resume()
    }
}

enum WebserviceError: Error {
    case other
}

func mainQueue(block: @escaping () -> ()) {
    DispatchQueue.main.async(execute: block)
}
