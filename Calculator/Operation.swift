//
//  Operation.swift
//  Calculator
//
//  Created by Gupta, Mrigank on 18/03/17.
//  Copyright © 2017 Gupta, Mrigank. All rights reserved.
//

import Foundation

struct Operation {
    var record: Stack<KeyValueOp>?
    var operate: Stack<KeyValueOp>?
    var numeric: Stack<KeyValueOp>?
}
