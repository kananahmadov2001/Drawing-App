Student: Kanan Ahmadov
Class: CSE 438 - Mobile Application Development
Assignment: Lab #3 (Drawing App)

This .txt file includes my both Creative Feature Explanation and Extra Credit Implementation.


---------------------------------------------------- Creative Feature Explanation ----------------------------------------------------

1. What I implemented:

I implemented three main functionalities: Undo & Redo, Saving to Photos Library, and Shape Duplication features.

- 1st feature: Undo & Redo functionality which allows users to revert or restore their actions while interacting with the drawing app. This includes undoing and redoing drawing, moving, resizing, and rotating shapes. The undo & redo feature applies to all modes of interaction (draw, move, and erase), allowing users to reverse their actions as needed. 

- 2nd feature: Saving to Photos Library feature, allowing users to save their current drawing to the Photos library. The app saves only the drawing without any interface controls, ensuring that the exported image contains only the drawing. (NOTE: The Saving to Photos Library feature only works on a physical device and not in the simulator, not sure exactly why, but might due to the simulator not supporting certain system-level permissions, including those required to save media to the Photos library.)

- 3rd feature: Shape Duplication feature, allowing users to easily create a duplicate of any selected shape on the canvas. The duplicated shape appears slightly offset from the original to avoid overlap, and users can perform undo/redo actions on the duplicated shape.

-------------------------------------------------------------------------------------------------------------------------------------

2. How I implemented it:

- 1st feature (Undo & Redo Functionality): I implemented the Undo/Redo feature by maintaining two stacks (undoStack and redoStack) to track the state of the drawing items at each action. Every time a change occurs (drawing, moving, erasing, pinching, or rotating), I save a snapshot of the current state in the undo stack, allowing the user to undo the action by reverting to the previous state. Similarly, the redo stack stores states when actions are undone, allowing the user to restore the most recent undone action. To handle this, I added a copy() method to the Shape class and its subclasses so that each shape can be cloned. Then modified the DrawingItem protocol to include the copy() method, allowing every drawing item to be copied. Incorporated undo/redo logic in the touch handling methods (touchesBegan, touchesMoved) and gesture handling methods (handlePinch, handleRotation) to ensure changes are properly tracked. This feature was more challenging than the basic functionalities since it required managing multiple states of the application (it took me a hell of time). It involved additional complexity in tracking different gestures.

- 2nd feature (Saving to Photos Library) (Proff. Piazza suggestion): In the code, I used UIGraphicsBeginImageContextWithOptions to capture the current drawing as an image and UIImageWriteToSavedPhotosAlbum to save it to the user's Photos library. I also included a completion handler that displays an alert message to notify the user if the save operation was successful or there was an error. For this feature, the following links were super helpful:
	
	- Using UIGraphicsBeginImageContextWithOptions, UIGraphicsGetImageFromCurrentImageContext for creating the image context: 
		https://stackoverflow.com/questions/5146008/how-to-use-uigraphicsbeginimagecontextwithoptions
		https://stackoverflow.com/questions/1112947/how-to-create-a-uiimage-from-the-current-graphics-context		
	
	- For saving the image to Photos Album and completion handler method: 
		https://www.hackingwithswift.com/example-code/media/uiimagewritetosavedphotosalbum-how-to-write-to-the-ios-photo-album
	
	- For Alerts: 
		https://medium.com/a-developer-in-making/uialertcontroller-in-swift-and-how-to-use-them-in-extension-or-in-custom-class-2d8dcf9cb292

- 3rd feature (Shape Duplication): I implemented the Shape Duplication feature by creating a copy of the currently selected shape when the user taps the Duplicate button. The duplicated shape is slightly offset to avoid overlapping with the original shape and is then added to the canvas. The current state of the canvas is saved to the undo stack before the duplication occurs, ensuring that the duplication action can be undone or redone. Finally, the canvas is redrawn, and the undo/redo buttons are updated accordingly.

-------------------------------------------------------------------------------------------------------------------------------------

3. Why I implemented it:

- 1st feature: The Undo & Redo functionality significantly improves the usability of the app. In real-world drawing or design apps, users frequently make mistakes or change their minds. Undo and redo capabilities offer users the flexibility to experiment freely without worrying about permanent consequences. It also enhances user control and makes the app more professional.

- 2nd feature: Saving to Photos Library feature enhances the usability of the app by allowing users to save their drawing to their device for later use or sharing. It’s a valuable functionality for creative applications.

- 3rd feature: The Shape Duplication feature enhances the flexibility and functionality of the drawing app, giving users the ability to efficiently replicate shapes. It allows users to create multiple instances of the same shape without having to redraw them manually. This can be particularly useful when working on complex designs where precision and repetition are important.

-------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------- Extra Credit Implementation -----------------------------------------------------

I implemented both Extra Credits: three Home Screen Actions for my Drawing App and implementing two subclasses of Shape, SolidShape and OutlineShape.


1) Three Home Screen Actions for my Drawing App:

- I basically added functionality in both the AppDelegate and SceneDelegate files. 
- First, in AppDelegate, I used the application(_:performActionFor:completionHandler:) method to detect which quick action the user selected and handled these actions in the handleQuickAction method. - (depending on the selected action, the current shape type (circle, rectangle, triangle) and drawing modes are set)
- In SceneDelegate, I accessed the shortcutItem from connectionOptions in scene(_:willConnectTo:options:), then called the same handleQuickAction method.


2) Implementing two subclasses of Shape, SolidShape and OutlineShape:

- I implemented two subclasses for each shape: solid and outlined. These subclasses include CircleShape, RectangleShape, TriangleShape, and their outline counterparts, OutlineCircleShape, OutlineRectangleShape, and OutlineTriangleShape. Each shape class has its own unique updatePath and draw methods, ensuring proper rendering, transformations, and rotation for both solid and outlined shapes. Additionally, I modified the view controller to handle the selection of different shape types and styles dynamically based on user input, allowing to toggle between drawing solid or outlined shapes and switch between different shapes. 


-------------------------------------------------------------------------------------------------------------------------------------

