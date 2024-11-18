//
//  CircleShape.swift
//  KananAhmadov-Lab-3
//
//  Created by Ahmadov, Kanan on 10/9/24.
//

import UIKit

class CircleShape: Shape {
    
    // initializing CircleShape
    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
        updatePath() // initial path for the circle
    }

    // overriding the updatePath method to define the circle's path
    override func updatePath() {
        bezierPath = UIBezierPath(arcCenter: origin, radius: size / 2, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        // rotation transform to rotate the circle around its origin and applying it to the bezier path
        let transform = CGAffineTransform(translationX: origin.x, y: origin.y)
            .rotated(by: rotation)
            .translatedBy(x: -origin.x, y: -origin.y)
        bezierPath?.apply(transform)
    }

    // overriding the draw method to fill and stroke the circle
    override func draw() {
        color.setFill()
        bezierPath?.fill()
        UIColor.black.setStroke()
        bezierPath?.stroke()
    }
}


