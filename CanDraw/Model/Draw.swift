//
//  Draw.swift
//  ICanDraw
//
//  Created by Thalia Freitas on 06/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import Foundation
import UIKit

class Draw {
    private let image: UIImageView
    private let brushWidth: CGFloat
    private let colorBrush: CGColor
    private let opacity: CGFloat
    init(imageViewForDraw: UIImageView, brushWidth: CGFloat, colorBrush: UIColor, opacity: CGFloat) {
        self.image = imageViewForDraw
        self.brushWidth = brushWidth
        self.colorBrush = colorBrush.cgColor
        self.opacity = opacity
    }
    func line(from fromPoint: CGPoint, to toPoint: CGPoint) {
        UIGraphicsBeginImageContext(image.frame.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        image.image?.draw(in: image.bounds)
        context.move(to: fromPoint)
        context.addLine(to: toPoint)
        
        context.setLineCap(.round)
        context.setBlendMode(.normal)
        context.setLineWidth(brushWidth)
        context.setStrokeColor(colorBrush)
        context.setAllowsAntialiasing(true)
        
        context.strokePath()
        
        image.image = UIGraphicsGetImageFromCurrentImageContext()
        image.alpha = opacity
        UIGraphicsEndImageContext()
    }
}
