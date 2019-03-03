//Name: Sucharita Das
#include "function.h"
#include "math.h"

//Ship assign function to assign 1 for every grid cell
void WaterVehicle::shipassign(int shiplength, int hpos, int vpos, char dir, int assigngrid[][10])
{
	//hpos horizontal starting position and vpos is vertical starting position
	assigngrid[hpos][vpos] = 1;

	//Determine ALL grid points based on length and direction
	for (int i = 0; i<shiplength;i++)
	{
		if (dir == 'H') //for Horizontal, increase the columns by ship length
		{
			assigngrid[hpos - 1][vpos + i - 1] = 1;
		}
		if (dir == 'V') //for Vertical, increase the rows by ship length
		{
			assigngrid[hpos + i - 1][vpos - 1] = 1;
		}
	}

}




//Printing the grid with "~"

void  Grid::gridprint(int row, int col, int grid[][10]) //This function is for to draw grid
{//prints the table
	for (int i = 0; i < row; i++)
	{
		for (int j = 0; j < col; j++)
		{
			cout << grid[i][j] << "~";// to draw grid
		}
		cout << endl;
	}

}
//..............................................................................................


	
//Drop bomb function to assign 1 for random grid cell for 15 cells

void Grid::dropbomb(int grid[][10])//Grid function 
{
	for (int i = 1; i <= 15; i++)
	{	
		grid[(int)rand() % 10][(int)rand() % 10] = 1;// calling the rand function to put 1 randomly 1/3 of the grid
	}
}

//Is Sunk function to compare grids to find out all 1s where both are equal, that mean a ship is hit
void Grid::issunk(int grid[][10], int grid1[][10])//Grid function 
{
	for (int i = 1; i <= 10; i++)
	{
		for (int j = 1; j <= 10; j++)
		{
			if (grid[i][j] == 1 && grid1[i][j] == 1)
			{
				cout << "Your ship was hit !!!" << endl;
			}
		}
	}
}
	//.....................................................................................................




