//
//  SceneViewController.swift
//  CanDraw
//
//  Created by Thalia Freitas on 13/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import UIKit
import ARKit
class SceneViewController: UIViewController {
    
    let customView = SceneAR(frame: .zero)
    var cursor: Position!
    
    var position = CGPoint(x: 0, y: 0)
    var draw: Draw!
    var drawing = false
    var action = false
    
    var timer: Timer?
    var timeLeft = 2
    var finishTimer = false
    var staticPosition = CGPoint(x: 0, y: 0)
    var verifyStop = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        draw = Draw(imageViewForDraw: customView.imageForDraw, brushWidth: 3.0, colorBrush: .black, opacity: 1.0)
    }
    
    func initialSetup() {
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
        customView.scene.delegate = self
        let screen = UIScreen.main.bounds
        let positionInitial = CGPoint(x: screen.width / 2, y: screen.height / 2)
        cursor = Position(sensibility: 0.5)
        position = positionInitial
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        customView.scene.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    override func loadView() {
        view = customView
    }
}
extension SceneViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.3, options: .transitionCrossDissolve, animations: {
                
                let facePosition = CGPoint(x: CGFloat(node.worldOrientation.y), y: CGFloat(node.worldOrientation.x))
                
                let lastPosition = self.position
                
                (self.position, self.drawing) = self.cursor.newPosition(facePosition: facePosition, cursorPosition: self.customView.cursor.center)
                
                if self.drawing == false && self.verifyStop == true {
                    self.initTimer()
                    self.staticPosition = self.position
                    self.verifyStop = false
                }
                
                if self.action == true {
                    self.InitialDraw(lastPoint: lastPosition, newPoint: self.position)
                }
                
                self.customView.cursor.center = self.position
            }, completion: nil)
        }
    }
    
    func InitialDraw(lastPoint: CGPoint, newPoint: CGPoint) {
        let drawPointLast = CGPoint(x: lastPoint.x - 12.0, y: lastPoint.y+10)
        let drawPointnew = CGPoint(x: newPoint.x - 12.0, y: newPoint.y+10)
        self.draw.line(from: drawPointLast, to: drawPointnew)
    }
    
    func finishDraw() {
        UIGraphicsBeginImageContext(customView.imageDraw.frame.size)
        customView.imageDraw.image?.draw(in: customView.imageDraw.bounds, blendMode: .normal, alpha: 1.0)
        customView.imageForDraw.image?.draw(in: customView.imageDraw.bounds, blendMode: .normal, alpha: 1.0)
        customView.imageDraw.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
    }
    
    func initTimer() {
        if finishTimer == false {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.onTimerDrawn), userInfo: nil, repeats: true)
            finishTimer = true
        }
        
    }
    
    @objc func onTimerDrawn() {
        timeLeft -= 1
        print("Fui ativado")
        if timeLeft <= 0 {
            timer?.invalidate()
            timer = nil
            timeLeft = 2
            verifyStop = true
            finishTimer = false
            if staticPosition == position {
                action = !action
                customView.cursor.image = UIImage(named: "lapis")
            }
        }
        if action == false {
            customView.cursor.image = UIImage(named: "lapis2")
            finishDraw()
        }
    }
    
}
