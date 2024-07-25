# Godot Drag and Drop Demo
This little project demonstrates the powerful, if somewhat convoluted, builtin drag and drop functionality in Godot. By default, any node that extends Control can be draggable if you implement _get_drag_data(at_position). This method should return whatever data you need to pass to the location you're dragging to, in this example it just returns itself. You then need to define locations where the object can be dragged to that implement the function _can_drop_data(at_position, data) which returns a boolean that indicates whether or not the currently dragged item can be deposited at this location. These "slots" also then need to define _drop_data(at_position, data) that runs when the object is dropped at this position. In my case, _drop_data(at_position, data) removes the dragged node from it's current parent and adds it as a child of the dropped slot.

In this demo, there is a simple card simulation. There is a "deck" that can be drawn into one of 7 hand slots. When drawn, each card randomizes non-exclusively (there can be multiples of each card). From the hand, cards can be moved to other hand slots or discarded.

There are 2 different methods of implementation:
- The native drag and drop functionality built into Godot
- Using invisible buttons to handle mouse events
