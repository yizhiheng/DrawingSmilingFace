//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Zhiheng Yi on 2015-05-28.
//  Copyright (c) 2015 Zhiheng Yi. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    var happiness: Int = 10 {
        // 0 - 100
        didSet {
            happiness = min(max(happiness, 0), 100)
            println("Happiness = \(happiness)")
            updateUI()
        }
    }
    private struct Constants {
        static let HappinessGestrureScale: CGFloat = 4
    }
    
    //下面是在view里添加的组件
    @IBAction func changeHappiness(sender: UIPanGestureRecognizer){
        switch sender.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestrureScale)
            if happinessChange != 0 {
                happiness = happiness + happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    

    func updateUI() {
        faceView.setNeedsDisplay()
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50)/50
    }

}
