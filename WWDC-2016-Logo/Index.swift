//
//  Index.swift
//  WWDC2016Logo
//
//  Created by Alberto De Bortoli on 23/06/2016.
//  Copyright © 2016 Alberto De Bortoli. All rights reserved.
//

import Foundation

// MARK: Equatable
func ==(lhs: Index, rhs: Index) -> Bool {
    if lhs.x == rhs.x && lhs.y == rhs.y {
        return true
    }
    else {
        return false
    }
}

struct Index {
    
    let value: AttributedString
    let x, y: Int
    
}
