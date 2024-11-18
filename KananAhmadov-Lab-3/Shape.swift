//
//  Shape.swift
//  CSE 438S Lab 3
//
//  Created by Michael Ginn on 5/31/21.
//

import UIKit

/**
 YOU SHOULD MODIFY THIS FILE.
 
 Feel free to implement it however you want, adding properties, methods, etc. Your different shapes might be subclasses of this class, or you could store information in this class about which type of shape it is. Remember that you are partially graded based on object-oriented design. You may ask TAs for an assessment of your implementation.
 */

/// A `DrawingItem` that draws some shape to the screen.
class Shape: DrawingItem {
    var origin: CGPoint
    var size: CGFloat = 100.0
    var color: UIColor
    var bezierPath: UIBezierPath?
    var rotation: CGFloat = 0.0

    required init(origin: CGPoint, color: UIColor) {
        self.origin = origin
        self.color = color
        self.bezierPath = nil
    }

    func updatePath() {
        // CircleShape, RectangleShape, TriangleShape, OutlineCircleShape, OutlineRectangleShape, OutlineTriangleShape implement this method to update their path
    }

    func draw() {
        // CircleShape, RectangleShape, TriangleShape implement this method to define how they are drawn
    }

    // checking if a given point is inside the shape
    func contains(point: CGPoint) -> Bool {
        return bezierPath?.contains(point) ?? false
    }
    
    // implementing the copy() method to create and return a duplicate of the shape
    func copy() -> DrawingItem {
        let copiedShape = type(of: self).init(origin: self.origin, color: self.color)
        copiedShape.size = self.size
        copiedShape.rotation = self.rotation
        copiedShape.updatePath()
        return copiedShape
    }

}
