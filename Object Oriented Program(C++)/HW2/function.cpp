//Name: Sucharita Das
#include "function.h"
#include "math.h"

void Grid::gridassign(int row, int col, int grid[][10])//Grid function 
{
	int random = (row*col) / 3;
	//assigns each element
	for (int i = 0; i < row; i++)
	{
		for (int j = 0; j < col; j++)
		{
			grid[i][j] = 0;// ((int)rand() % 2);
		}
	}

	for (int i = 1; i <= random; i++)
	{
		//cout << (int)rand() % random << endl;
		//grid[(int)rand() % i][(int)rand() % i] = 1;
		grid[(int)rand() % random][(int)rand() % random] = 1;// calling the rand function to put 1 randomly 1/3 of the grid

	}
}
void Grid::gridprint(int row, int col, int grid[][10]) //This function is for to draw grid
{//prints the table
	for (int i = 0; i < row; i++)
	{
		for (int j = 0; j < col; j++)
		{
			//cout << " ---";// to draw grid
			cout << grid[i][j] <<  "|   ";// to draw grid
		}
		cout << endl;
	}
	
	}


	
