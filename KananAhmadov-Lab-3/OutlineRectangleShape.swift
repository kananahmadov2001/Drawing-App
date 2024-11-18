//
//  OutlineRectangleShape.swift
//  KananAhmadov-Lab-3
//
//  Created by Ahmadov, Kanan on 10/9/24.
//

import UIKit

class OutlineRectangleShape: Shape {

    // initializing OutlineRectangleShape
    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
        updatePath() // initial path for the rectangle outline
    }

    // overriding the updatePath method to define the rectangle's path
    override func updatePath() {
        let rect = CGRect(x: origin.x - size / 2, y: origin.y - size / 2, width: size, height: size)
        bezierPath = UIBezierPath(rect: rect)
        // rotation transform to rotate the rectangle around its origin and applying it to the bezier path
        let transform = CGAffineTransform(translationX: origin.x, y: origin.y)
            .rotated(by: rotation) // current rotation angle
            .translatedBy(x: -origin.x, y: -origin.y)
        bezierPath?.apply(transform)
    }

    // overriding the draw method to stroke the outline of the rectangle
    override func draw() {
        color.setStroke()
        bezierPath?.lineWidth = 3
        bezierPath?.stroke()
    }
}
