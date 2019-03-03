//Name: Sucharita Das
//Include the files
#ifndef _FUNCTION_H
#define _FUNCTION_H
#include <iostream>

using namespace std;
//Define WaterVehicle class
class WaterVehicle
{	
public:
	int length;
	string name;
	int c[][10];

void shipassign( int shiplength, int hpos, int vpos, char dir, int assigngrid[][10]);
};

//Define Grid class
class Grid
{

public:
	int column;//Variables
	int row;

	int d[][10];	//public variable
	 		
	
		void gridprint(int row, int col, int grid[][10]);
	
		void dropbomb(int grid[][10]);
		
		void issunk(int grid[][10], int grid1[][10]);
};
#endif


