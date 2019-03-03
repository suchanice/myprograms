//Name: Sucharita Das
//Include the files
//Name: Sucharita Das
#ifndef _FUNCTION_H
#define _FUNCTION_H
#include <iostream>

using namespace std;
//Define Grid class
class Grid
{
	int column;//Variables
	int row;
public: 
	int a[][10];	//public variable
	

	void gridassign(int row, int col, int grid[][10]);
	void gridprint(int row, int col, int grid[][10]);
};
#endif