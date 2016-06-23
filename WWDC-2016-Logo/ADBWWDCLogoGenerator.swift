//
//  ADBWWDCLogoGenerator.swift
//  WWDC2016Logo
//
//  Created by Alberto De Bortoli on 23/06/2016.
//  Copyright © 2016 Alberto De Bortoli. All rights reserved.
//

import Foundation
import UIKit

func + (left: AttributedString, right: AttributedString) -> AttributedString
{
    let result = NSMutableAttributedString()
    result.append(left)
    result.append(right)
    return result
}

@objc protocol ADBWWDCLogoGeneratorDelegate {
    func wwdcLogo(generator: ADBWWDCLogoGenerator, didUpdateASCII newString: AttributedString)
}

@objc class ADBWWDCLogoGenerator: NSObject {

    @objc var delegate: ADBWWDCLogoGeneratorDelegate?
    
    let queue = DispatchQueue(label: "bkgQueue")
    var numberOfSubstitutions: Int
    var timeInterval: TimeInterval {
        didSet {
            timer?.invalidate()
            timer = nil
            timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(ADBWWDCLogoGenerator.fireTimer), userInfo: nil, repeats: true)
        }
    }
    
    let body: String
    let symbols: [[Symbol]]
    
    private var internalStructure: [[Index]]
    private var listOfIndexes: [Index]?
    private var listsOfSymbols: [[Symbol]]
    private var timer: Timer?
    private var iterationCounter: Int
    
    init(body: String, symbols: [[Symbol]]) {
        self.body = body
        self.symbols = symbols
        self.numberOfSubstitutions = 20 // default
        self.timeInterval = 0.2 // default
        self.iterationCounter = 0
        
        self.internalStructure = [[Index]]()
        self.listsOfSymbols = symbols
        
        super.init()
        
        self.internalStructure = structure(body: body)
        self.listOfIndexes = calculateListOfIndexes()
    }
    
    func fireTimer() -> Void {
//        queue.async {
            self.applySubstitution()
//            DispatchQueue.main.async(execute: {
                if let delegate = self.delegate {
                    delegate.wwdcLogo(generator: self, didUpdateASCII: self.generateStringFromDataStructure())
                }
//            })
//        }
    }
    
    func start(time: TimeInterval) -> Void {
        internalStructure = clearValuesInStructure()
        timeInterval = time
    }
    
    func stop() -> Void {
        timer?.invalidate()
        timer = nil
    }
    
    func structure(body: String) -> [[Index]] {
        
        var retVal = [[Index]]()
        
        for (x, line) in body.components(separatedBy: "\n").enumerated() {
            var y = 0
            var newLine = [Index]()
            for char in line.characters {
                newLine.append(Index(value: AttributedString(string: String(char)), x: x, y: y))
                y += 1
            }
            retVal.append(newLine)
        }
        
        return retVal
    }
    
    func calculateListOfIndexes() -> [Index] {
        
        var retVal = [Index]()
        let space = AttributedString(string: " ")
        
        for (y, row) in internalStructure.enumerated() {
            for (x, index) in row.enumerated() {
                if !index.value.isEqual(to: space) {
                    retVal.append(Index(value: index.value, x: x, y: y))
                }
            }
        }
        
        return retVal
    }
    
    func clearValuesInStructure() -> [[Index]] {
        
        return internalStructure.map({ $0.map({ (value) -> Index in return Index(value: AttributedString(string: " "), x: value.x, y: value.y) }) })
    }
    
    func randomIndexes(listOfIndexes: [Index]) -> [Index] {
        
        let numberOfRandomIndexes = min(numberOfSubstitutions, listOfIndexes.count)
        var retVal = [Index]()
        
        for _ in 0..<numberOfRandomIndexes {
            retVal.append(listOfIndexes.randomObject())
        }
        return retVal
    }
    
    func generateStringFromDataStructure() -> AttributedString {
        
        // use flatMap
        
        var retVal = AttributedString()
        
        for (_, row) in internalStructure.enumerated() {
            var mutAttrStr = AttributedString()
            
            for (_, index) in row.enumerated() {
                let attrStr = index.value
                mutAttrStr = mutAttrStr + attrStr
            }
            
            mutAttrStr = mutAttrStr + AttributedString(string: "\n")
            
            retVal = retVal + mutAttrStr
        }
        
        return retVal
    }
    
    func applySubstitution() -> Void {
        
        iterationCounter += 1
        let step = 50
        let symbolsIndex = (iterationCounter / step) % listsOfSymbols.count
        
        let symbols = listsOfSymbols[symbolsIndex]
        let randoms = randomIndexes(listOfIndexes: listOfIndexes!)
        
        for idx in randoms {
            let s = symbols.randomObject()
            let len = s.value.characters.count
            
            let color = s.associatedColors.randomObject()
            
            if (len > 1) {
                
                if (idx.x + len - 1 < internalStructure[idx.y].count) {
                    let valueAtMostRightIndex = internalStructure[idx.y][idx.x + len - 1]
                    
                    let isContained = listOfIndexes?.contains({ (elem) -> Bool in
                        elem == valueAtMostRightIndex
                    })
                    
                    if (isContained!) {
                        for i in 0..<len {
                            let subStr = String((s.value as NSString).substring(from: i).characters.first!)
                            let attrs = [NSForegroundColorAttributeName : color]
                            let attrStr = AttributedString(string: subStr, attributes: attrs)
                            let index = Index(value: attrStr, x: idx.x, y: idx.y)
                            internalStructure[idx.y][idx.x + i] = index
                        }
                    }
                }
            }
            else {
                let attrs = [NSForegroundColorAttributeName : color]
                let attrStr = AttributedString(string: s.value, attributes: attrs)
                let index = Index(value: attrStr, x: idx.x, y: idx.y)
                internalStructure[idx.y][idx.x] = index
            }
        }
    }
}
