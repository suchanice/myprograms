#ifndef VEHICLE_H
#define VEHICLE_H
#include <iostream>
#include <vector>
#include "function.h"
using namespace std;

class Vehicle
{
	
public:
	string make, model; int year;
	Vehicle(); //Default constructor
	Vehicle( string make, string model, int year);

	//constructor

	void binaryRecMake(vector<Vehicle>&car2, string endResult, int lownum, int highnum);
	void binaryRecModel(vector<Vehicle>&car2, string endResult, int lownum, int highnum);
	void binaryRecYear(vector<Vehicle>&car2, string endResult, int lownum, int highnum);

	void binaryItrMake(vector<Vehicle>&car2, string endResul);
	void binaryItrModel(vector<Vehicle>&car2, string endResul);
	void binaryItrYear(vector<Vehicle>&car2,  int yr);


	string getmake();
	string getmodel();
	string getyear();
}; 
#endif