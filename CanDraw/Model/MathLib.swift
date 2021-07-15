//
//  MathLib.swift
//  CanDraw
//
//  Created by Thalia Freitas on 13/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import Foundation
import UIKit

struct MathLib {
    func normalize(value: CGFloat, decimalValue: CGFloat) -> CGFloat {
           let normalizeValue = floor(decimalValue * value)
           let newValue = CGFloat(normalizeValue / decimalValue)
           return newValue
       }
}
