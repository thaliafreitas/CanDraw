//
//  Position.swift
//  CanDraw
//
//  Created by Thalia Freitas on 14/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import Foundation
import UIKit

class Position {
    
    private var lastPosition: CGPoint!
    private var newPosition = CGPoint(x: 0.0, y: 0.0)
    private var sensibility: CGFloat =  0.5
    var firstPosition = true
    init(sensibility: CGFloat) {
        self.sensibility =  sensibility
    }
    
    func newPosition(facePosition: CGPoint, cursorPosition: CGPoint) -> (CGPoint, Bool) {
        
        var drawing = false
        
        if firstPosition == true {
            lastPosition = cursorPosition
            newPosition = cursorPosition
        }
        
        lastPosition = newPosition
        
        if facePosition.x > 0.05 {
            newPosition.x = cursorPosition.x + self.sensibility
            drawing = true
        }
        
        if facePosition.x < -0.05 {
            newPosition.x = cursorPosition.x - self.sensibility
            drawing = true
        }
        
        if facePosition.y > 0.2 {
            newPosition.y = cursorPosition.y + self.sensibility
            drawing = true
        }
        
        if facePosition.y < -0.02 {
            newPosition.y = cursorPosition.y - self.sensibility
            drawing = true
        }
        
        if drawing == true {
             newPosition = verifyLimits(position: newPosition, lastPosition: lastPosition)
        }

        return (position: newPosition, draw: drawing)
    }
    
    func verifyLimits(position: CGPoint, lastPosition: CGPoint) -> CGPoint {
        
        var positionNew = position
        let height = UIScreen.main.bounds.height
        let width = UIScreen.main.bounds.width
        
        if position.x > width  || position.x < 0 + 25 {
            positionNew.x = lastPosition.x
        }
        
        if position.y > height - 30 || position.y < 0 + 30 {
            print(position.y)
            positionNew.y = lastPosition.y
        }
        
        return positionNew
    }
}
