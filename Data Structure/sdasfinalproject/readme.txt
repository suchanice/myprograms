*******************************************************
*  Name      :   Sucharita Das       
*  Student ID:                 
*  Class     :  CSC 2421           
*  Due Date  :  6th December,2028
*******************************************************


                 Read Me


*******************************************************
*  Description of the program
*******************************************************

The database is to handle multiple records, each composed of several fields.  The database will store its information to a file, addition and deletion of records, field modifications, and it will allow users to sort records based on the selected keys, and produce reports (output) according to predefined criteria.
 Load ALL CSV files (it might take up to 3 min)
 Display Records
 Add a record
Find a record (by exact value)
 Modify a record
 Delete a record
Sort records by field
Search for a records (by partial match
Write to CSV file

*******************************************************
*  Source files
*******************************************************

Name:  main.cpp
Main program.  main.cpp callstarts the menu display, which calls all the options

Name:  BSTDriver.cpp
 
Driver program demonstrating creating a tree, adding, finding and deleting nodes

Name: BSTree.h
   
Used in conjunction with Node.h and BSTree<DATATYPE, KEYTYPE>.cpp, used to declare BSTree class and all of its methods and properties, both private and public. It also defines nodes.

Name: csv.cpp
    
implementation file for csv utility
    contains utility functions for reading/writing vectors of
    unordered maps to/from csv 



Name:  DataSet.h  
Header file to define DataSet class and all of its methods and properties, both private and public. Here the vectors are declared. Also the unordered_map is used here for partial and exact value search, which is declared here. Also functions for writedata on screen and write data on csv is declared.

Name: MenuDisplay.h
MenuDisplay Class to define all functions and methods used in the options for the users.



Name: Node.h
Declare Node class and vectors for left, right, parent and all public functions.

Name: Operator.h
Defines the ostream for out data


Name:  MenuDisplay.cpp
    Implemantaion file for MenuSystem class
    contains the entire user interface  menu.



Name:  MenuDisplay.h
    
Declaration file for MenuSystem class
 that contains the entire user interface IO menu 



Name:  BSTree.hpp 
   


Name:  operators.h
    
declaration file for read/write operators for items in BST
    this is admitedly a little bit hacky, but I didn't change
    the pre-impleneted BSTree.hpp from the table.cpp



Name:  BSTDriver.cpp
Driver program demonstrating creating a tree, adding, finding and deleting nodes

Name: BSTree.hpp
Defines BSTree templates and various functions to free node, add node, find node, print node, sorting, delete node, min and max node.

Name: csv.cpp
Utility functions for reading CSV functions to/from vectors of unordered maps - reading and writing from and to csv, to and from screen and to file. 

Name: DataSet.cpp
 DataSet data structure with for column names from the top of the CSV. Partial and exact search functions for nodes, remove record function, replace, add, read, write all crucial functions are defined in this program.

Name: main.cpp
Calling the MenuDisplay file and going through the loop

Name: MenuDisplay.cpp
Providing option to the users, taking input from user and executing corresponding functions.Calling the functions from other files to load files into dataset in binary tree and executing all the functions.
   
*******************************************************
*  Status of program
*******************************************************

   The program runs successfully.  
   
   The program was developed and tested on Visual Studios and g++.  It was 
   compiled, run, and tested on csegrid.ucdenver.pvt.

