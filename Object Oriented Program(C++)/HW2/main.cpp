/*
Name: Sucharita Das
CSCI : 2313
Status: Program running properly*/

//Include the needed files

#include "function.h"// declearing header file file in the main function
#include <iostream>
#include <vector>//Needed to define vector
#include "math.h"
#include<stdlib.h>
#include<time.h>
using namespace std;
//menu

int main()
{
	vector<vector<int> > v;  // declare a vector 

	int row, col, k; //variables
	cout << "How many rows?: "; //Asking for input from user but they need to put the no with in 10 to draw row
	cin >> row;
	cout << "How many Columns?: "; //Asking for input from user but they need to put the no with in 10 to draw column
	cin >> col;
	cout << "Rows and Columns are " << row << " and " << col << endl;
	int grid1[10][10]; //taking upto 10th grid
	int grid2[10][10];
	int grid3[10][10];


	Grid tempgrid; 
	
	cout << "Displaying first grid " << endl;
	tempgrid.gridassign( row,  col, grid1);
	tempgrid.gridprint( row,  col,  grid1);
	cout << endl;cout << endl;
	cout << "Displaying Second grid " << endl;
	tempgrid.gridassign(row, col, grid2);
	tempgrid.gridprint(row, col, grid2);
	cout << endl;cout << endl;
	//assigns each element
	for (int i = 0; i < row; i++)
	{
		for (int j = 0; j < col; j++)
		{
			if ((grid1[i][j] == 1) && (grid2[i][j] == 1))
				grid3[i][j] = 1;
			else grid3[i][j] = 0;

		}
	}
	cout << endl;
	cout << "Comparing two grids" << endl;
	
	cout << "Displaying Third grid..after comparison " << endl;
	tempgrid.gridprint(row, col, grid3);//Calling grid print function to draw the grid
	
	cin >> k;
	
	return 0;


}