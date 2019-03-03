#include <iostream>
#include <ctime>
#include <sstream>
#include <cstdlib>
#include <iostream>
#include <string>
#include <fstream>
#include <filesystem>

using namespace std;
using std::ifstream;


class Gameboard //Gameboard class to draw the game board
{
private:
	char grid[10][10];
public:
	void gamestart() 
	{//to display left hand side of each board and will display 1 to 10 virtically
		for (int r = 0; r<10; r++)//creating rows
		{
			for (int c = 0; c<10; c++) //creating coloumn
			{
				grid[r][c] = '-';
			}
		}
	}
	void display(bool hideShips = false)//this function will display horrizontally output on the top of each board 
	{
		int y = 1;
		cout << "   A B C D E F G H I J" << endl;// will display on the top of each grid 
		for (int i = 0; i<10; i++) 
		{
			if (y != 10) { cout << " "; }
			cout << y;
			for (int c = 0; c<10; c++) 
			{
				cout << " ";
				if (grid[i][c] == 'X') 
				{
					if (hideShips == true) 
					{ cout << "-";	}
					else {	cout << grid[i][c];}
				}
				else { cout << grid[i][c]; }
			}
			y++;
			cout << endl;
		}
		
	}
	char getSpace(int x, int y) 
	{
		return grid[y][x];
	}
	void addX(char space, int x, int y)  //this is the function to define Hit 
	{
		grid[y][x] = space; //since variable "space" is 'X', it will assign X in the grid
		
	}
};
//....................................................................
class ShipPos //ship position class to set get and set for the user's ship positions from the csv file
{
private: string TypeOfShip; string XPos; int YPos; string HorizOrVer;//variables
public: ShipPos() {}//default constructor
		ShipPos(string TypeOfShip, string XPos, int YPos, string HorizOrVer) {}//constructor
		string getTypeOfShip() { return TypeOfShip; }
		void setTypeOfShip(string newTypeOfShip) {TypeOfShip = newTypeOfShip;}
		int getXPos() {
			/*typedef enum {A=1,B=2,C=3,D=4,E=5,F=6,G=7,H=8,I=9,J=10}Xp;
			switch (Xp) { case 'A':1;case 'B':2; }*/
			if (XPos == "A" || XPos == "a") return 1;//Position will work irrespective of lower or upper cases
	   else if (XPos == "B" || XPos == "b") return 2; //defining all sorts of inputs
	   else if (XPos == "C" || XPos == "c") return 3;
	   else if (XPos == "D" || XPos == "d") return 4;
	   else if (XPos == "E" || XPos == "e") return 5;
	   else if (XPos == "F" || XPos == "f") return 6;
	   else if (XPos == "G" || XPos == "g") return 7;
	   else if (XPos == "H" || XPos == "h") return 8;
	   else if (XPos == "I" || XPos == "i") return 9;
	   else if (XPos == "J" || XPos == "j") return 10;
	   else return 0;
			 }
		void setXPos(string newXPos) { XPos = newXPos; }//to set x-coordinate position
		int getYPos() { return YPos; }
		void setYPos(int newYPos) { YPos = newYPos; }// to set y- coordinate position
		string getHorizOrVer() { return HorizOrVer; }
		void setHorizOrVer(string newHorizOrVer) { HorizOrVer = newHorizOrVer; }
};
class ship //ship class
{
private:
	int length;//variables
	Gameboard* GameboardA;
public:
	ship(int L, Gameboard* BA) {
		length = L;
		GameboardA = BA;		
	}
	bool shipplacement(int *X, int *Y, int dX, int dY,  int len, string dir, Gameboard *GameboardA) //function to placement ship for use's grid
	{
		int shipStore[10] = { -1,-1,-1,-1,-1,-1,-1,-1,-1,-1 };
		for (int c = 0; c <len; c ++)
		{
			if (dir == "h" || dir == "H") {	GameboardA->addX('X', *X+c-1 ,*Y-1 );	}
			else { GameboardA->addX('X', *X - 1, *Y + c - 1); }
		} 
		return true;		
	}

	bool shipplacementpc(int *X, int *Y, int dX, int dY, Gameboard *GameboardA) //function to place ships for computer
	{
		int shipStore[10] = { -1,-1,-1,-1,-1,-1,-1,-1,-1,-1 };
		for (int i = 0; i<length; i++) {
			shipStore[i * 2] = *X;
			shipStore[i * 2 + 1] = *Y;
			if (*Y + dY<10 && *Y + dY>-1
				&& *X + dX<10 && *X + dX>-1
				&& GameboardA->getSpace(*X + dX, *Y + dY) == '-') {
				*Y = *Y + dY;
				*X = *X + dX;
			}
			else { return false; }
		}
		for (int c = 0; c / 2<length; c += 2) {
			GameboardA->addX('X', shipStore[c], shipStore[c + 1]);
		}
		return true;
	}

	int getLength() { return length; }
};

class Player  //Player class
{
protected:
	Gameboard* userGridA;
	Gameboard* anotherA;
	int X;
	int Y;
	int hits;
public:
	virtual void go() {}//virtual function
	Player() { 	hits = 0;		}
	bool won() {
		if (hits == 17) { 	return true;	} //17 hits define a Win, 17 comes from addition of all spaces taken by all ships
		else { return false; }
	}
	bool hit() //boolean function if it will be hit by fire 
	{
		if (anotherA->getSpace(X - 1, Y - 1) == 'X') {
			cout << "Hit!" << endl;
			hits++;
			anotherA->addX('#', X - 1, Y - 1);
			return true;
		}
		else {
			cout << "Miss!" << endl;// if does not hit it will show miss 
			anotherA->addX('O', X - 1, Y - 1);
			return false;
		}
	}

	void shipplacementpc() { //shipplacementpc function is for pc to randomly place all ship types in the grid
		ship Carrier(5, userGridA); //carrier ship will take 5 spaces
		positionShipRandompc(&Carrier); //positionShipRandompc is called everytime

		ship Battleship(4, userGridA); //battleship will take 4 spaces
		positionShipRandompc(&Battleship);

		ship Cruiser(3, userGridA); //cruiser will take 3 spaces
		positionShipRandompc(&Cruiser);

		ship Destroyer(2, userGridA); //destroyer will take 2 spaces
		positionShipRandompc(&Destroyer);

		ship Submarine(3, userGridA); // submerine will take 3 spaces in the grid
		positionShipRandompc(&Submarine);
	}


	void positionShipRandompc(ship* type) //random function to place ship for computer
	{ //this function will use random function to position the ship for computer and will call shipplacementpc function
		while (1) {
			int dY = 0;
			int dX = 0;
			int len = 0;
			dX = (rand() % 2) - (rand() % 2); //random function between 0 to 2 for variables
			if (dX == 0) {
				dY = (rand() % 2);
				if (dY == 0) { (dY)--; }
			}
			else { dY = 0; }
			int Y = (rand() % 10); //random function between 0 to 10 for the grid
			int X = (rand() % 10);
			if (userGridA->getSpace(X, Y) == '-') {
				if (type->shipplacementpc(&X, &Y, dX, dY, userGridA) == false) {
					dX *= -1;
					dY *= -1;
					if (type->shipplacementpc(&X, &Y, dX, dY, userGridA) == true) { return; }
				}
				else { return; }
			}
		}
	}

	void shipplacement() { //this is the ship placement function for the user
		ship Carrier(5, userGridA);
		positionShip(&Carrier);
	}

	void positionShip(ship* type) //function to place ships for user's grid
	{ //here all the ship positions will be read from the file and ship will be placed
		ShipPos sp;
		ofstream file;
		string st, st1, st2, st3, st4;
		int num; string dir1;
		ifstream inStream;
		//**************************************************************
		inStream.open("ship_placement.csv");// open cvs file and read from the and then will place ships for user's grid
		try // try and catch funtion if there will be any exception to open the file
		{
			if (!inStream) {
				cout << "Unable to open file";
				exit(1);
			}
			num = 0;
			cout << "The Ship Details from the files are : " << endl;
			while (inStream.good()) {//reading from file and setting the values in variable
				getline(inStream, st1, ','); sp.setTypeOfShip(st1);
				getline(inStream, st2, ','); sp.setXPos(st2);
				getline(inStream, st3, ','); sp.setYPos(atoi(st3.c_str()));
				getline(inStream, st4, '\n'); sp.setHorizOrVer(st4);
				cout << "TypeOfShip : " << sp.getTypeOfShip() << endl; //displaying what is there on the file
				cout << "XPos : " << sp.getXPos() << endl;
				cout << "YPos : " << sp.getYPos() << endl;
				cout << "Horizontal Or Vertical : " << sp.getHorizOrVer() << endl;
				cout << "----------------------------------------------" << endl;
				int len = 0, dX = 0, dY = 0;
				int Y = sp.getYPos(); //assigning the values to the variables through get functions from the shippos class
				int X = sp.getXPos();
				string Stype = sp.getTypeOfShip();
				if (Stype == "Carrier") { len = 5; } //assigning different length for different types of ships
				else if (Stype == "Battleship") { len = 4; }
				else if (Stype == "Cruiser") { len = 3; }
				else if (Stype == "Submarine") { len = 3; }
				else if (Stype == "Destroyer") { len = 2; }
				else { len = 0; }
				dir1 = sp.getHorizOrVer();
				if (userGridA->getSpace(X, Y) == '-') {
					if (type->shipplacement(&X, &Y, dX, dY, len, dir1, userGridA) == false) {
						dX *= -1;dY *= -1;
						if (type->shipplacement(&X, &Y, dX, dY, len, dir1, userGridA) == true) { /*return;*/ }
					}
					else { /*return;*/ }
				}


			}
		}
		catch (int e)
		{
			cout << "Unable to open file: " << endl;// will return this output if cannot open the file
		}
		inStream.close();// cvs file closed
	}

};
//.........................................................................................
class User : public Player //derived class player from User main class
{
public:
	User(Gameboard* tBA, Gameboard* oBA)
	{
		userGridA = tBA;
		anotherA = oBA;
	}
	void go() {
		setCordinate();//this function will take input from user and will show output accordingly
		hit();
		cout << "Coordiates you entered for x  : "<< X << " and  for y : " << Y << endl;		
	}
	void setCordinate() { //interaction with the user for the input
		string input;
		while (1) {
			do {
				cout << endl << "Enter x coordinate (enter letter A to J): ";
				char xCordinate = '\0';
				cin >> input;
				if (input.length() == 1) { xCordinate = input[0]; }
				X = LettertoNum(xCordinate);
				if (X == 0) { cout << "Please enter a valid letter between A-J :" << endl; }
			} while (X == 0);
			do {
				cout << "Enter y coordinate (enter a number from 1 to 10):  " ;
				cin >> input;
				stringstream(input) >> Y;
				if (Y>10 || Y<1) { cout << "Please enter a valid number between 1-10" << endl; }
			} while (Y>10 || Y<1);
			if (anotherA->getSpace(X - 1, Y - 1) == '#'
				|| anotherA->getSpace(X - 1, Y - 1) == 'O') {
				cout << endl << "Please do not put a space that has already been hit!" << endl;
			}
			else { break; }
		}
	}
	int LettertoNum(char ltr) //this function is taking ascci value of A to J and a to j
	{
		if (int(ltr)>64 && int(ltr)<75) {
			return int(ltr) - 64;
		}
		else if (int(ltr)>96 && int(ltr)<107) {
			return int(ltr) - 96;
		}
		return 0;
	}
};
//.....................................................................
class Computer : public Player // derived class Player from main class computer
{
private://variables
	int Xpt;
	int Ypt;
	int vX;
	int vY;
	bool type1;
	bool type2;
	bool DirSearch;
	bool oppositeCheck;
	int gap;
	int count;
public:
	Computer(Gameboard* tBA, Gameboard* oBA) {
		userGridA = tBA;
		anotherA = oBA;
		Xpt = 0;
		Ypt = 0;
		vX = 0;
		vY = 0;
		type1 = false;
		type2 = false;
		DirSearch = false;
		oppositeCheck = false;
		gap = 2;
		count = 0;
	}
	void go() {
		setCordinate();
		if (hit() == true) {
			if (Xpt == 0) {
				Xpt = X;
				Ypt = Y;
			}
			else if (DirSearch == false) {
				DirSearch = true;
				if (oppositeCheck == true) {
					if (vX<0 || vY<0) {
						type1 = true;
					}
					else { type2 = true; }
				}
			}
		}
		else if (DirSearch == true) {
			if (X - Xpt>0 || Y - Ypt>0) {
				type1 = true;
			}
			else { type2 = true; }
		}
	}
	void setCordinate() // function for setCordinate
	{
		if (Xpt != 0) {
			if (type1 == false
				|| type2 == false) {
				if (DirSearch == false) {
					findDirection();
				}
				else {
					findRest();
				}
			}
			if (type1 == true
				&& type2 == true) {
				Xpt = 0;
				Ypt = 0;
				vX = 0;
				vY = 0;
				type1 = false;
				type2 = false;
				DirSearch = false;
				oppositeCheck = false;
				gap = 2;
				count = 0;
			}
		}
		if (Xpt == 0) {
			do {
				X = (rand() % 10) + 1;
				Y = (rand() % 10) + 1;
			} while (anotherA->getSpace(X - 1, 10 - Y) == 'O'
				|| anotherA->getSpace(X - 1, 10 - Y) == '#');
		}
	}
	void findDirection() //function to fun direction
	{
		if (count == 0) {
			vX = (rand() % 2) - (rand() % 2);
			if (vX == 0) {
				vY = (rand() % 2);
				if (vY == 0) { (vY)--; }
			}
			else { vY = 0; }
		}
		while (count<4) {
			if (count == 2) {
				oppositeCheck = false; int i = vX; vX = vY; vY = i;
			}
			else if (count != 0) { oppositeCheck = true; vX *= -1; vY *= -1; }
			count++;
			if (Xpt + vX<11 && Xpt + vX>0
				&& Ypt + vY<11 && Ypt + vY>0
				&& anotherA->getSpace((Xpt + vX) - 1, 10 - (Ypt + vY)) != '#'// if will hit will place #
				&&anotherA->getSpace((Xpt + vX) - 1, 10 - (Ypt + vY)) != 'O')// if miss then will place O
			{
				X = Xpt + vX;
				Y = Ypt + vY;
				return;
			}
		}
		type1 = true;
		type2 = true;
	}
	void findRest() {
		int alter = 0;
		if (type1 == true) {
			if (vX<0 || vY<0) {
				alter = 1;
			}
			else { alter = -gap; }
		}
		else if (type2 == true) {
			if (vX<0 || vY<0) {
				alter = -gap;
			}
			else { alter = 1; }
		}
		else {
			alter = (rand() % 2);
			if (alter == 0) { alter = -gap; }
		}
		if (vX<0 || vY<0) { alter *= -1; }
		int i = 0;
		while (i<2 && (type1 == false || type2 == false)) {
			if (vX == 0) {
				if (Ypt + vY + alter>0
					&& Ypt + vY + alter<11
					&& anotherA->getSpace(Xpt - 1, 10 - (Ypt + vY + alter)) != '#'
					&&anotherA->getSpace(Xpt - 1, 10 - (Ypt + vY + alter)) != 'O') {
					Y = Ypt + vY + alter;
					if (alter == 1 || alter == -1) { vY += alter; }
					gap++;
					return;
				}
			}
			else {
				if (Xpt + vX + alter>0
					&& Xpt + vX + alter<11
					&& anotherA->getSpace((Xpt + vX + alter) - 1, 10 - Ypt) != '#'
					&&anotherA->getSpace((Xpt + vX + alter) - 1, 10 - Ypt) != 'O') {
					X = Xpt + vX + alter;
					if (alter == 1 || alter == -1) { vX += alter; }
					gap++;
					return;
				}
			}
			if (alter == 1) {
				alter = -gap; type1 = true;
			}
			else if (alter == -1) {
				alter = gap; type2 = true;
			}
			else if (alter == gap) {
				alter = -1; type1 = true;
			}
			else { alter = 1; type2 = true; }
			i++;
		}

	}
};
//..................................................................................................
int main() {
	int winner;//variable

	srand((unsigned int)(time(0)));
	Gameboard GameboardO1;//to draw grid to play batteleship game
	GameboardO1.gamestart(); //set the game board for the user
	Gameboard GameboardO2;//second game board function call for computer
	GameboardO2.gamestart();
	User Person1(&GameboardO2, &GameboardO1);//calling the function for the person
	Person1.shipplacement();//this function is for user
	Computer Comp(&GameboardO1, &GameboardO2); //calling the function for the computer
	Comp.shipplacementpc();//this function for computer
	Player* PlayerA = &Person1;
	while (1) {//This board will track the shooting hits
		cout << "This board will track the shooting hits !" << endl;
		GameboardO1.display(true);
		cout << "This is the battleship board & ship positions:" << endl;
		GameboardO2.display();
		PlayerA->go();
		if (PlayerA->won() == true) {
			cout << endl;
			if (PlayerA == &Person1) {
				cout << "You win the game!" << endl;
				cin >> winner;
			}
			else {
				cout << "Computer wins the game!" << endl;
				cin >> winner;
			}
			GameboardO1.display(true);
			GameboardO2.display();
			break;
		}
		if (PlayerA == &Person1) {
			PlayerA = &Comp;
		}
		else { PlayerA = &Person1; }
	}

	return 0;
}