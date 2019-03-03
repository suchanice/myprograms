
//SucharitaDas

#include <iostream>
#include <vector>
#include<string>
#include <fstream>
#include <algorithm>
#include "vehicle.h"
#include "function.h"

using namespace std;

int main()
{
	
	string make1, model1; int year1;
	
	vector<Vehicle>vectorCar;
	
	//vector of sting and int to hold the value whenever reading from the file
	//declaring all the vectors, you can declare any numbers
	vector<Vehicle>firstcarvector;
	vector<Vehicle>secondcarvector;
	vector<Vehicle>thirdcarvector;
	vector<Vehicle>forthcarvector;
	vector<Vehicle>fifthcarvector;
	Vehicle car;
	int vectorCarSize = vectorCar.size();
	ifstream infile("vehiclein.txt");// Opening the text file 
	{
		infile >> make1;
		infile.ignore();
		getline(infile, model1);
		car = Vehicle(make1, model1, year1);
		vectorCar.push_back(car);
	}

	for (int i = 0; i < vectorCar.size(); i++)
	{
		firstcarvector.push_back(vectorCar[i]); //pushing back the vector
		secondcarvector.push_back(vectorCar[i]);
		thirdcarvector.push_back(vectorCar[i]);
		forthcarvector.push_back(vectorCar[i]);
		fifthcarvector.push_back(vectorCar[i]);
	}

	sortMake(vectorCar);//calling the sortMake function
	vectorCar.binaryRecMake(vectorCar, "Ford",0, vectorCarSize); //calling the binary search by make function
	sortModel(firstcarvector);  //sort by model
	vectorCar.binaryRecModel(firstcarvector, "328xi", 1); // calling the binary search by model function on a particular model
	vectorCar.binaryItrMake(secondcarvector, "Ford");  //iterative search for Ford, using binary iterative search on make
	vectorCar.binaryItrModel(secondcarvector, "328xi", 1); //iterative search for model, using binary iterative search on Ford Model

	return 0;
	infile.close();// closing the text file
}