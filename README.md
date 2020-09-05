# ToDo List
Simple iOS App, done as guided project for learning purposes in 2020 May.

[Description](#description)

[Implementation](#implementation)

[References](#references)

## Description:
This App manages a list of ToDo items and stores it away for later retrieval. User can add, modify, and delete items in the list using a custom input screen. Each ToDo has a due date and a set of notes; it can be marked as complete, but remains in the list until the user deletes it.

#### This app handles the following actions:

  1. Display the list.
  
  2. Add items to the list.
  
  3. Edit existing items on the list.
  
  4. Delete items from the list.
  
  5. Automatically save the list to disk.
<br>
<br>
<br>
  
## Implementation: 
There are two table views used for that app:

<img src="/ToDoList-screens/tableViews.png" width="95%">
<br>

1. The __first Table View__ is a Prototype Table View and initially is an empty table, where User can start adding an information about his favorite Books.

<img src="/ToDoList-screens/to-do-list_01.png" width="33%"> <img src="/ToDoList-screens/to-do-list_02.png" width="33%">

After User has pressed _Add_ button, next will be initialized _second Table View_.
<br>
<br>

2. The __second Table View__ is a Static Table View, where each text field is in its own cell and each cell is in its own section. There are five sections. First four enables User to add such information as:
  * Book Title
  * Author
  * Genre
  * Length
  
<img src="/ToDoList-screens/to-do-list_03.png" width="33%"> <img src="/ToDoList-screens/to-do-list_04.png" width="33%">

And the last section is for the _Save_ button.
<br>
<br>

3. After information about Book is added and _Save_ button was pressed, App will come back to the first screen. Here again will be provided a list containing all saved Books with included recently saved Book:

<img src="/ToDoList-screens/to-do-list_05.png" width="33%">

This list enables User to see all added Books, also select and edit each Book by tapping on it's row. For sure, is still possible to add next new Book by pressing _Add_ button in top-right screen corner.
<br>
<br>

4. Delete existing Book function could be enabled by sweaping selected Book's row from the right to the left as same common way as for other wellknown iOS Apps:

<img src="/ToDoList-screens/to-do-list_05.png" width="33%"> <img src="/ToDoList-screens/to-do-list_06.png" width="33%">
<br>   
<br>
<br>

## References:
“App Development with Swift”. Apple Inc. - Education, 2019. Apple Books. pages: 737-779
https://books.apple.com/us/book/app-development-with-swift/id1465002990
