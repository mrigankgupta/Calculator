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
    
    mutating func pop()->Element {
        return items.removeLast()
    }
    
    mutating func push(_ newItem:Element) {
        items.append(newItem)
    }
    
    mutating func empty() {
        items.removeAll()
    }
    
    var topItem:Element? {
        return items.isEmpty ? nil:items[items.count-1]
    }
}
