//
//  ViewController.swift
//  WWDC2016Logo
//
//  Created by Alberto De Bortoli on 23/06/2016.
//  Copyright © 2016 Alberto De Bortoli. All rights reserved.
//

import UIKit

class ViewController_Swift: UIViewController, ADBWWDCLogoGeneratorDelegate {
    
    @IBOutlet weak var label: UILabel? = nil
    @IBOutlet weak var numberOfSubstitutionsSlider: UISlider? = nil
    @IBOutlet weak var timeIntervalSlider: UISlider? = nil
    var generator: ADBWWDCLogoGenerator?

    func setup() -> Void {
        
        let filePath = Bundle.main().pathForResource("AppleLogo-small", ofType: "txt")!
        do {
            let body = try String(contentsOfFile: filePath)
            generator = ADBWWDCLogoGenerator(body: body, symbols: SymbolFactory().defaultListOfListSymbols())
            generator?.delegate = self
            generator?.numberOfSubstitutions = Int((numberOfSubstitutionsSlider?.value)!)
            generator?.start(time: TimeInterval((timeIntervalSlider?.value)!))
        } catch {
            //
        }
    }
    
    // MARK: ADBWWDCLogoGeneratorDelegate
    
    func wwdcLogo(generator: ADBWWDCLogoGenerator, didUpdateASCII newString: AttributedString) {
        
        let attrString: NSMutableAttributedString = NSMutableAttributedString(attributedString: newString)
        attrString.addAttributes([NSFontAttributeName: UIFont(name: "Courier New", size: 8)!], range: NSMakeRange(0, attrString.string.characters.count))
        
        UIView.transition(with: label!, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.label!.attributedText = attrString as AttributedString
            }, completion: nil)
    }
    
    // MARK: Actions
    
    @IBAction func numberOfSubstitutionsDidChange(sender: UISlider) -> Void {
        generator?.numberOfSubstitutions = Int(sender.value)
    }
    
    @IBAction func timeIntervalDidChange(sender: UISlider) -> Void {
        generator?.timeInterval = TimeInterval(sender.value)
    }
    
    @IBAction func start(sender: AnyObject) -> Void {
        generator?.stop()
        setup()
    }
}

