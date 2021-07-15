//
//  CodeView.swift
//  CanDraw
//
//  Created by Thalia Freitas on 13/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import Foundation

protocol CodeView {
    func setupViews()
    func viewHierarchy()
    func setupConstraints()
}

extension CodeView {
    
    func setupViews() {
        viewHierarchy()
        setupConstraints()
    }
}
