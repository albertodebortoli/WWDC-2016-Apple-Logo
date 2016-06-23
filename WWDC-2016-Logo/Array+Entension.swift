//
//  ArrayEntension.swift
//  WWDC2016Logo
//
//  Created by Alberto De Bortoli on 22/06/2016.
//  Copyright © 2016 Alberto De Bortoli. All rights reserved.
//

import Foundation

extension Array {
    
    func randomObject() -> Element {
        return self[Int(arc4random_uniform(UInt32(self.count)))]
    }
    
}
