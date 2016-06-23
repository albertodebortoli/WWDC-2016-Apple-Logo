//
//  SymbolFactory.swift
//  WWDC2016Logo
//
//  Created by Alberto De Bortoli on 22/06/2016.
//  Copyright © 2016 Alberto De Bortoli. All rights reserved.
//

import Foundation
import UIKit

struct SymbolFactory {
    
    // MARK: Chars
    
    func chars1() -> [String] {
        return ["<", ">", "=", ".", "+", "-", "_", "(", ")", ":"]
    }
    
    func chars2() -> [String] {
        return ["0", "@", "o", "+"]
    }
    
    func chars3() -> [String] {
        return ["\\", "/", "~", "-", "*"]
    }
    
    func chars4() -> [String] {
        return ["do", "let", "var", "in", "for", "as", "if", "try"] + chars1() + chars2() + chars3() + chars5()
    }
    
    func chars5() -> [String] {
        return ["*", "+", "-", "[", "]"]
    }
    
    func symbols(colors: [UIColor], chars: [String]) -> [Symbol] {
        var retVal: [Symbol] = []
    
        for char in chars {
            retVal.append(Symbol(value: char, associatedColors: colors))
        }
        
        return retVal
    }
    
    // MARK: Colors
    
    func colors1() -> [UIColor] {
        
        let c1 = UIColor.turquoiseColor()
        let c2 = UIColor.greenSeaColor()
        let c3 = UIColor.emeraldColor()
        let c4 = UIColor.nephritisColor()
        let c5 = UIColor.peterRiverColor()
        let c6 = UIColor.belizeHoleColor()
        
        return [c1, c2, c3, c4, c5, c6]
    }
    
    func colors2() -> [UIColor] {
        
        let c1 = UIColor.peterRiverColor()
        let c2 = UIColor.belizeHoleColor()
        let c3 = UIColor.amethystColor()
        let c4 = UIColor.wisteriaColor()
        let c5 = UIColor.wetAsphaltColor()
        let c6 = UIColor.midnightBlueColor()
        
        return [c1, c2, c3, c4, c5, c6]
    }
    
    func colors3() -> [UIColor] {
        
        let c1 = UIColor.sunFlowerColor()
        let c2 = UIColor.carrotColor()
        let c3 = UIColor.flatOrangeColor()
        let c4 = UIColor.alizarinColor()
        let c5 = UIColor.pomegranateColor()
        
        return [c1, c2, c3, c4, c5]
    }
    
    // MARK: Symbols
    
    func defaultListOfListSymbols() -> [[Symbol]] {
        return [symbols1(), symbols2(), symbols3(), symbols4(), symbols5()]
    }
    
    func symbols1() -> [Symbol] {
        return symbols(colors: colors1(), chars: chars1())
    }
    
    func symbols2() -> [Symbol] {
        return symbols(colors: colors3(), chars: chars2())
    }
    
    func symbols3() -> [Symbol] {
        return symbols(colors: colors2(), chars: chars3())
    }
    
    func symbols4() -> [Symbol] {
        return symbols(colors: colors1(), chars: chars4())
    }
    
    func symbols5() -> [Symbol] {
        return symbols(colors: colors2(), chars: chars5())
    }
    
}
