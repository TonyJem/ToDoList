# ToDo List
Simple iOS App, done as guided project for learning purposes in 2020 May.

[Description](#description)

[Implementation](#implementation)

[References](#references)

## Description:
This App manages a list of ToDo items and stores it away for later retrieval. User can add, modify, and delete items in the list using a custom input screen. Each ToDo has a due date and a set of notes; it can be marked as complete, but remains in the list until the user deletes it.

#### This app handles the following actions:

  1. Display the list, containing data retrieved from disk.
  
  2. Add new items to the list.
  
  3. Edit existing items on the list.
  
  4. Delete items from the list.
  
  5. Search field enables User to search throught items.
  
  6. Automatically save the list to disk.
<br>
<br>
<br>
  
## Implementation: 
There are two table views used for that app:

<img src="/ToDoList-screens/tableViews.png" width="95%">
<br>

1. The __first Table View__ is a Prototype Table View and initially is a list displaying retrieved from disk data that was saved previuosly, since App was used last time. In that list each raw represents one single ToDo:

<img src="/ToDoList-screens/to-do-list_01.png" width="33%"> 

There is possible to add new ToDo by pressing _Add_ button in top-right screen corner. After User has pressed _Add_ button, next will be initialized _second Table View_.
<br>
<br>

2. The __second Table View__ is a Static Table View, where each cell is in it's own section. There are three sections, where is essential to:
  * Add Basic Info
  * Set Due Date
  * Add some Notes for better ToDo's description
  
<img src="/ToDoList-screens/to-do-list_02.png" width="33%"> 

After adding all esential ToDo's information, in top-right screen's corner it will be enabled _Save_ button, which enables to save new ToDo to the list. When new ToDo was added and _Save_ button was pressed, App will come back to the first screen. Here again will be provided a list containing all ToDos with included recently saved ToDo:


Other ScreenShots:



<img src="/ToDoList-screens/to-do-list_03.png" width="33%"> <img src="/ToDoList-screens/to-do-list_04.png" width="33%"> <img src="/ToDoList-screens/to-do-list_05.png" width="33%">


<br>
<br>



<img src="/ToDoList-screens/to-do-list_05.png" width="33%"> <img src="/ToDoList-screens/to-do-list_06.png" width="33%">
<br>   
<br>
<br>

## References:
“App Development with Swift”. Apple Inc. - Education, 2019. Apple Books. pages: 737-779
https://books.apple.com/us/book/app-development-with-swift/id1465002990
