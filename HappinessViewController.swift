//
//  HappinessViewController.swift
//  
//
//  Created by Rafael Martins on 22/11/15.
//
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    var happiness: Int = 100 {
        didSet {
            happiness = min(max(happiness, 0),100)
            updateUI()
        }
    }
    
    private struct Constants {
        static let HappinessGestureScale:CGFloat = 4
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    func smilenessForFaceView(sender: FaceView) -> Double? {
        return Double(happiness - 50) / 50
    }
    
    @IBAction func changedHapiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            let happinessChange = -Int(translation.y / Constants.HappinessGestureScale)
            if happinessChange != 0 {
                happiness += happinessChange
                gesture.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }

    
}
