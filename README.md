<div align="center">
    <h1 id="Header">Drawing App</h1>
</div>


## Overview
```
Note: I developed this project as my Lab 3 assignment for my Mobile App. Dev. class at WashU.
```

The Drawing App is an interactive mobile application that allows users to create, manipulate, and display shapes dynamically. This project was designed to practice advanced mobile app development with Swift, focusing on custom UI elements, state management, and object-oriented design patterns. The app provides an engaging drawing experience with features like shape selection, resizing, and interactive manipulation.

<div align="center">
    <img src="Drawing-Vertical.png" alt="screenshot" height="700px">
</div>

## Technologies/Frameworks Used
- **Language**: Swift
- **Frameworks**: UIKit, Auto Layout
- **Tools**: Xcode, Interface Builder
- **Design Pattern**: MVC (Model-View-Controller)

## Features
1. **Shape Selection**:  
   Users can select from multiple shapes to draw:
   - Circle
   - Rectangle
   - Triangle
   - Outlined versions of each shape.

2. **Interactive Drawing Canvas**:  
   - Users can place shapes on the canvas by tapping.
   - Shapes can be moved, resized, and deleted interactively.

3. **Customizable Shapes**:  
   - Each shape has customizable properties such as size and color.

4. **Undo/Redo Functionality**:  
   - Users can undo or redo their actions, making the drawing process more intuitive.

## Project Structure
1. **CircleShape.swift**: Defines the `CircleShape` class, including methods for rendering and resizing circular shapes.
2. **RectangleShape.swift**: Defines the `RectangleShape` class, handling the creation and manipulation of rectangle shapes.
3. **TriangleShape.swift**: Implements the `TriangleShape` class, focusing on triangular shape geometry and rendering.
4. **OutlineCircleShape.swift**: Extends the `CircleShape` class to add outline-specific features.
5. **OutlineRectangleShape.swift**: Adds functionality for rendering rectangles with outlines.
6. **OutlineTriangleShape.swift**: Implements outlined triangle rendering and manipulation.
7. **DrawingItem.swift**: Represents individual drawable items on the canvas, managing their state and interactions.
8. **DrawingView.swift**: Handles the overall drawing canvas, rendering all shapes and responding to user inputs.
9. **ViewController.swift**: Manages the app's main UI and links user interactions to the underlying logic.

