//
//  ViewController.swift
//  Fridgemate
//
//  Created by MakeSchool on 7/14/16.
//  Copyright © 2016 Kadeem. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TapToStartButton: UILabel!
    
    var counter: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let repeatingFunction: Selector = #selector(ViewController.pulseButton)
        _ = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: repeatingFunction, userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func pulseButton() {
        counter += 1.0
        
        // calculate elapsed time
        let adjustmentFactor = (counter / 100.0) % 10.0
        var sizeAdjustment: Double = 0.0
        var alphaAdjustment: Double = 0.0
        
        // increase size and alpha
        if (adjustmentFactor < 5) {
            sizeAdjustment = (80.0 + 4.0 * adjustmentFactor) / 100.0
            alphaAdjustment = (40.0 + 12.0 * adjustmentFactor) / 100.0
        }
            // decrease size and alpha
        else {
            sizeAdjustment = (120.0 - 4.0 * adjustmentFactor) / 100.0
            alphaAdjustment = (160.0 - 12.0 * adjustmentFactor) / 100.0
        }
        
        TapToStartButton.font =  UIFont(name: (TapToStartButton.font?.fontName)!, size: 75.0 * CGFloat(sizeAdjustment))
        TapToStartButton.alpha = CGFloat(alphaAdjustment)
    }
    
}



