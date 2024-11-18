//
//  OutlineTriangleShape.swift
//  KananAhmadov-Lab-3
//
//  Created by Ahmadov, Kanan on 10/9/24.
//

import UIKit

class OutlineTriangleShape: Shape {

    // initializing OutlineTriangleShape
    required init(origin: CGPoint, color: UIColor) {
        super.init(origin: origin, color: color)
        updatePath() // initial path for the triangle outline
    }

    // overriding the updatePath method to define the triangle's path
    override func updatePath() {
        bezierPath = UIBezierPath()
        // triangle points relative to the origin
        bezierPath?.move(to: CGPoint(x: origin.x, y: origin.y - size / 2))
        bezierPath?.addLine(to: CGPoint(x: origin.x - size / 2, y: origin.y + size / 2))
        bezierPath?.addLine(to: CGPoint(x: origin.x + size / 2, y: origin.y + size / 2))
        bezierPath?.close()
        // rotation transform to rotate the triangle around its origin and applying it to the bezier path
        let transform = CGAffineTransform(translationX: origin.x, y: origin.y)
            .rotated(by: rotation)
            .translatedBy(x: -origin.x, y: -origin.y)
        bezierPath?.apply(transform)
    }

    // overriding the draw method to stroke the outline of the triangle
    override func draw() {
        color.setStroke()
        bezierPath?.lineWidth = 3
        bezierPath?.stroke()
    }
}
