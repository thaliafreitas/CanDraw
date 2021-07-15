//
//  SceneAR.swift
//  CanDraw
//
//  Created by Thalia Freitas on 13/01/21.
//  Copyright © 2020 Thalia Freitas. All rights reserved.
//

import UIKit
import ARKit
class SceneAR: UIView {
    let scene: ARSCNView = {
        let scene = ARSCNView()
        scene.translatesAutoresizingMaskIntoConstraints = false
        return scene
    }()
    let cursor: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lapis")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let imageForDraw: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .white
        return image
    }()
    
    let imageDraw: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SceneAR: CodeView {
    func viewHierarchy() {
        addSubview(scene)
       
        addSubview(imageDraw)
        addSubview(imageForDraw)
        addSubview(cursor)
    }
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cursor.heightAnchor.constraint(equalToConstant: 40),
            cursor.widthAnchor.constraint(equalToConstant: 40),
            cursor.centerXAnchor.constraint(equalTo: centerXAnchor),
            cursor.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            imageDraw.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageDraw.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageDraw.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageDraw.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            imageForDraw.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imageForDraw.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            imageForDraw.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            imageForDraw.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0)
        ])
    }
    
}
