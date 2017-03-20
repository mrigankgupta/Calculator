//
//  Stack.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 17/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

struct Stack<Element> {
    var items = [Element]()
    
    var topItem:Element? {
        return items.isEmpty ? nil:items[items.count-1]
    }
    
    mutating func popSafe()->Element? {
        return items.popLast()
    }
    
    mutating func pop()->Element {
        return items.removeFirst()
    }
    
    mutating func push(_ newItem:Element) {
        items.append(newItem)
    }
    
    mutating func empty() {
        items.removeAll()
    }
    
}
