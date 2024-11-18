//
//  ViewController.swift
//  KananAhmadov-Lab-3
//
//  Created by Ahmadov, Kanan on 10/9/24.
//

import UIKit
import Photos

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // the view
    @IBOutlet weak var drawingView: DrawingView!
    // color buttons
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var purpleButton: UIButton!
    // controls for selecting shape type and mode
    @IBOutlet weak var shapeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var modeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var shapeStyleSegmentedControl: UISegmentedControl!
    // clear all button
    @IBOutlet weak var clearButton: UIBarButtonItem!
    // undo and redo buttons
    @IBOutlet weak var undoButton: UIBarButtonItem!
    @IBOutlet weak var redoButton: UIBarButtonItem!
    // duplicate button
    @IBOutlet weak var duplicateButton: UIBarButtonItem!
    // saving drawings to photo library button
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // variables to track current selections
    var currentShape: Shape?
    var currentMode: DrawingMode = .draw
    var currentShapeType: ShapeType = .rectangle
    var currentColor: UIColor = .red
    var initialSize: CGFloat = 0
    var initialRotation: CGFloat = 0
    var initialOrigin: CGPoint = .zero
    var isOutlineMode: Bool = false
    
    // stacks for undo/redo functionality
    var undoStack: [[DrawingItem]] = []
    var redoStack: [[DrawingItem]] = []
    
    // array to store color buttons for easy access
    var colorButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        colorButtons = [redButton, orangeButton, yellowButton, greenButton, blueButton, purpleButton]
        setupPaleColorButtons()
        setupGestureRecognizers()
        updateSelectedColorButton(selectedButton: redButton, brightColor: UIColor.red)
        updateUndoRedoButtons()
    }

    // setting the pale colors for all color buttons
    func setupPaleColorButtons() {
        redButton.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        orangeButton.backgroundColor = UIColor.orange.withAlphaComponent(0.3)
        yellowButton.backgroundColor = UIColor.yellow.withAlphaComponent(0.3)
        greenButton.backgroundColor = UIColor.green.withAlphaComponent(0.3)
        blueButton.backgroundColor = UIColor.blue.withAlphaComponent(0.3)
        purpleButton.backgroundColor = UIColor.purple.withAlphaComponent(0.3)
        
        // making each button circular
        for button in colorButtons {
            button.layer.cornerRadius = button.frame.size.width / 2
            button.clipsToBounds = true
        }
    }

    // updating the selected color button to a bright color and resetting others to pale
    func updateSelectedColorButton(selectedButton: UIButton, brightColor: UIColor) {
        setupPaleColorButtons()
        selectedButton.backgroundColor = brightColor.withAlphaComponent(1.0)
    }

    // setting up gesture recognizers for pinching and rotating shapes
    func setupGestureRecognizers() {
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let rotateRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
        pinchRecognizer.delegate = self
        rotateRecognizer.delegate = self
        
        view.addGestureRecognizer(pinchRecognizer)
        view.addGestureRecognizer(rotateRecognizer)
    }

    // handling undo action
    @IBAction func undoButtonTapped(_ sender: UIBarButtonItem) {
        if !undoStack.isEmpty {
            redoStack.append(drawingView.items.map { $0.copy() })
            let lastAction = undoStack.removeLast()
            drawingView.items = lastAction.map { $0.copy() }
            drawingView.setNeedsDisplay()
            updateUndoRedoButtons()
        }
    }
    
    // handling redo action
    @IBAction func redoButtonTapped(_ sender: UIBarButtonItem) {
        if !redoStack.isEmpty {
            undoStack.append(drawingView.items.map { $0.copy() })
            let lastRedo = redoStack.removeLast()
            drawingView.items = lastRedo.map { $0.copy() }
            drawingView.setNeedsDisplay()
            updateUndoRedoButtons()
        }
    }
    
    // handling the duplication of selected shape
    @IBAction func duplicateButtonTapped(_ sender: UIBarButtonItem) {
        guard let shape = currentShape else { return }
        let duplicatedShape = shape.copy() as! Shape
        duplicatedShape.origin.x += 30
        duplicatedShape.origin.y += 30
        saveToUndoStack()
        drawingView.items.append(duplicatedShape)
        drawingView.setNeedsDisplay()
        updateUndoRedoButtons()
    }
    
    // handling the saving to photo library
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        UIGraphicsBeginImageContextWithOptions(drawingView.bounds.size, false, 0.0)
        drawingView.drawHierarchy(in: drawingView.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let imageToSave = image {
            UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(imageSaved(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    // completion handler for saving the image
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if error != nil {
            showAlert(title: "Error", message: "Failed:")
        } else {
            showAlert(title: "Success", message: "Image saved to Photos!")
        }
    }

    // ensuring that any changes can be undone by the user
    func saveToUndoStack() {
        undoStack.append(drawingView.items.map { $0.copy() })
        redoStack.removeAll()
        updateUndoRedoButtons()
    }

    // handling availability of undo & redo buttons
    func updateUndoRedoButtons() {
        undoButton.isEnabled = !undoStack.isEmpty
        redoButton.isEnabled = !redoStack.isEmpty
    }

    // helper function to display alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    // handling color button taps to change the drawing color
    @IBAction func redButtonTapped(_ sender: UIButton) {
        currentColor = .red
        updateSelectedColorButton(selectedButton: redButton, brightColor: UIColor.red)
    }
    @IBAction func orangeButtonTapped(_ sender: UIButton) {
        currentColor = .orange
        updateSelectedColorButton(selectedButton: orangeButton, brightColor: UIColor.orange)
    }
    @IBAction func yellowButtonTapped(_ sender: UIButton) {
        currentColor = .yellow
        updateSelectedColorButton(selectedButton: yellowButton, brightColor: UIColor.yellow)
    }
    @IBAction func greenButtonTapped(_ sender: UIButton) {
        currentColor = .green
        updateSelectedColorButton(selectedButton: greenButton, brightColor: UIColor.green)
    }
    @IBAction func blueButtonTapped(_ sender: UIButton) {
        currentColor = .blue
        updateSelectedColorButton(selectedButton: blueButton, brightColor: UIColor.blue)
    }
    @IBAction func purpleButtonTapped(_ sender: UIButton) {
        currentColor = .purple
        updateSelectedColorButton(selectedButton: purpleButton, brightColor: UIColor.purple)
    }

    // handling shape style
    @IBAction func shapeStyleChanged(_ sender: UISegmentedControl) {
        // index 0 is Solid, index 1 is Outline
        isOutlineMode = sender.selectedSegmentIndex == 1
    }
    
    // handling shape changes from the segmented control
    @IBAction func shapeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            currentShapeType = .rectangle
        case 1:
            currentShapeType = .circle
        case 2:
            currentShapeType = .triangle
        default:
            break
        }
    }

    // handling mode changes from the segmented control
    @IBAction func modeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                currentMode = .draw
            case 1:
                currentMode = .move
            case 2:
                currentMode = .erase
            default:
                break
        }
    }
    
    // handling the clear button to remove all shapes from the canvas
    @IBAction func clearCanvasTapped(_ sender: UIBarButtonItem) {
        saveToUndoStack()
        drawingView.items.removeAll()
        drawingView.setNeedsDisplay()
        updateUndoRedoButtons()
    }

    // handling touch events based on the selected mode
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: drawingView) else { return }

        saveToUndoStack() // saving state before drawing a new shape or performing an action

        switch currentMode {
        case .draw:
            // determining if the shape is solid or outline and create the appropriate shape
            switch currentShapeType {
            case .circle:
                currentShape = isOutlineMode ? OutlineCircleShape(origin: touchPoint, color: currentColor) : CircleShape(origin: touchPoint, color: currentColor)
            case .rectangle:
                currentShape = isOutlineMode ? OutlineRectangleShape(origin: touchPoint, color: currentColor) : RectangleShape(origin: touchPoint, color: currentColor)
            case .triangle:
                currentShape = isOutlineMode ? OutlineTriangleShape(origin: touchPoint, color: currentColor) : TriangleShape(origin: touchPoint, color: currentColor)
            }

            currentShape?.size = 100
            currentShape?.updatePath()
            if let shape = currentShape {
                drawingView.items.append(shape)
            }

        case .move:
            currentShape = drawingView.itemAtLocation(touchPoint) as? Shape
            initialOrigin = touchPoint

        case .erase:
            if let shape = drawingView.itemAtLocation(touchPoint) {
                if let index = drawingView.items.firstIndex(where: { $0 === shape }) {
                    drawingView.items.remove(at: index)
                }
            }
        }

        drawingView.setNeedsDisplay()
        updateUndoRedoButtons()
    }


    // handling touch movement to move shapes in move mode
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchPoint = touches.first?.location(in: drawingView), let shape = currentShape else { return }

        if currentMode == .move {
            let deltaX = touchPoint.x - initialOrigin.x
            let deltaY = touchPoint.y - initialOrigin.y
            shape.origin.x += deltaX
            shape.origin.y += deltaY
            initialOrigin = touchPoint
            shape.updatePath()
        }

        drawingView.setNeedsDisplay()
    }

    // handling pinch gesture to resize shapes in move mode
    @IBAction func handlePinch(_ sender: UIPinchGestureRecognizer) {
        guard let shape = drawingView.itemAtLocation(sender.location(in: drawingView)) as? Shape else { return }

        if currentMode == .move {
            if sender.state == .began {
                undoStack.append(drawingView.items.map { $0.copy() })
                redoStack.removeAll()
                initialSize = shape.size
            } else if sender.state == .changed {
                shape.size = initialSize * sender.scale
                shape.updatePath()
                drawingView.setNeedsDisplay()
            } else if sender.state == .ended {
                undoStack.append(drawingView.items.map { $0.copy() })
                updateUndoRedoButtons()
            }
        }
    }
    
    // handling rotation gesture to rotate shapes in move mode
    @IBAction func handleRotation(_ sender: UIRotationGestureRecognizer) {
        
        guard let shape = drawingView.itemAtLocation(sender.location(in: drawingView)) as? Shape else { return }

            if currentMode == .move {
                if sender.state == .began {
                    undoStack.append(drawingView.items.map { $0.copy() })
                    redoStack.removeAll()
                    initialRotation = shape.rotation
                } else if sender.state == .changed {
                    // updating the shape's rotation based on the gesture's rotation
                    shape.rotation = initialRotation + sender.rotation
                    shape.updatePath()
                    drawingView.setNeedsDisplay()
                } else if sender.state == .ended {
                    // saving the final state after rotation for undo/redo
                    undoStack.append(drawingView.items.map { $0.copy() })
                    updateUndoRedoButtons()
                }
            }
    }


    // simultaneous pinch and rotate gestures in move mode
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return currentMode == .move
    }
}

// calculating the distance between two points
class Functions {
    static func distance(a: CGPoint, b: CGPoint) -> CGFloat {
        return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2))
    }
}

// representing different shapes
enum ShapeType {
    case circle, rectangle, triangle
}

// representing different interaction modes
enum DrawingMode {
    case draw, move, erase
}
