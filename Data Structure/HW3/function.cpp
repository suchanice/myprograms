#include <iostream>
#include <vector>
#include<string>
#include <fstream>
#include <algorithm>
#include "vehicle.h"
#include "function.h"
using namespace std;

bool sortByMake(Vehicle sm, Vehicle sm1)
{
	return sm.getmake() < sm1.getmake(); //boolean function for string sort for make
}

bool sortByModel(Vehicle sm2, Vehicle sm3)
{
	return sm2.getmodel() < sm3.getmodel(); //boolean function for string sort by model

}

bool sortByYear(Vehicle sy, Vehicle sy1)
{
	return sy.getyear() < sy1.getyear();//boolean function for string sort by year
}



//bubble sort with vector

void sortMake(vector<string>& car)
{
	sort(car.begin(), car.end(), sortByMake);
}

void sortModel(vector<string>& car)//bubble sort function for model of the car
{
	sort(car.begin(), car.end(), sortByModel);

}

void sortYear(vector<int>& car)//bubble sort function for model of the car
{
	sort(car.begin(), car.end(), sortByYear);
}