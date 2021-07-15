//
//  Sequence+Sum.swift
//  CanDraw
//
//  Created by Thalia Freitas on 13/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import Foundation
extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}
