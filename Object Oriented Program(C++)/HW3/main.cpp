/*
Name: Sucharita Das
CSCI : 2313
Status: Program running properly*/

//Include the needed files
#include "function.h"// declearing header file file in the main function
#include <iostream>
#include "math.h"
#include <vector>//Needed to define vector
#include<stdlib.h>
#include<time.h>
using namespace std;
//menu

int main()
{
	char go;
	cout << "Would you you like to play Battleship Game (y or n)? \n"; //Asking to the players that they want to play or not
	cin >> go;
	if (go == 'y' || go == 'Y') //input can be Y or y to start the game
	
    int row, col, k; //variables
	
	bool done = false;

	const char isHIT = 'X';
	const char isSHIP = 'S';
	const char isMISS = '0';



	while (!done)
	{

		WaterVehicle ship;
		Grid gridship;

		int b[10][10];
		int c[10][10];
		cout << "Enter 1 for Carrier" << endl;
		cout << "Enter 2 for Battelship" << endl;
		cout << "Enter 3 for Cruiser" << endl;
		cout << "Enter 4 for Submerrine" << endl;
		cout << "Enter 5 for Destroyer" << endl;
		cout << "Enter 6 for Exit " << endl;
		int menu;
		cin >> menu;
		cout << "Enter H for Horizontal and V for Vertical positioning for your ship " << endl;
		char direction;
		cin >> direction;
		cout << "Enter starting co-ordinates for your ship. For example, for Row 2 and Column 4, Enter 2 4 " << endl;
		int rowpos, colpos;
		cin >> rowpos >> colpos;
		cout << "You have chosen the following :" << endl;
		cout << "Your Ship is (as per chart above) " << menu << endl;
		cout << "Your Horizontal and Vertical Position is " << direction << endl;
		cout << "Your Ship co-ordinates are  " << rowpos << " and " << colpos << endl;

		//read user input . input should be 
		//defining the ship types and its length
		switch (menu)
		{
		case 1: ship.name = "Cruiser";  ship.length = 3; break;
		case 2: ship.name = "Destroyer"; ship.length = 2; break;
		case 3:	ship.name = "Submarine"; ship.length = 3; break;
		case 4:	ship.name = "Carrier"; ship.length = 5; break;
		case 5:	ship.name = "Battleship"; ship.length = 4; break;
		case 6: exit;
		}

		//Calling functions for the grid print
		gridship.gridprint(10,10,b);
		//Calling the ship assign function

		ship.shipassign(ship.length, rowpos, colpos, direction,b);
		//calling the dropbomb function
		gridship.dropbomb(c);
		//comparing two grids to find out whether the ship is sunk, calling the issunk function
		gridship.issunk(b, c);

	}

}


	
