//
//  Result.swift
//  TronaldDump
//
//  Created by Emil Marashliev on 3.01.18.
//  Copyright © 2018 Emil Marashliev. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(Error)

    init(_ value: T?, or error: Error) {
        if let value = value {
            self = .success(value)
        } else {
            self = .error(error)
        }
    }
    
    var value: T? {
        guard case .success(let v) = self else { return nil }
        return v
    }
}
