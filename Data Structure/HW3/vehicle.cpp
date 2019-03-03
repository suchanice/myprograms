#include <iostream>"
#include <string>
#include "vehicle.h"
using namespace std;

Vehicle::Vehicle()

{
//Default constructor
}

Vehicle::Vehicle(string make, string model, int year) //constructor
{

	make = make; model = model; year = year;

}





//Recursive function for make
void Vehicle::binaryRecMake(vector<Vehicle>& car2, string endResult, int lownum, int highnum)  
{

	if (highnum > lownum)
	{
		int midnum = (lownum + highnum) / 2;  //getting middle point
		if (car2[midnum].getmake() > endResult)
		{
			return binaryRecMake(car2, endResult, lownum, midnum); //calling the function again - recursive call
		}
		else if (car2[midnum].getmake() < endResult)
		{
			return binaryRecMake(car2, endResult, midnum, highnum);//calling the function again - recursive call
		}

		else
		{
			cout << "The year is " << car2[midnum].getyear() << "The made by "  << car2[midnum].getmake() << "The model of the car is  " << car2[midnum].getmodel() << endl;
			//return midnum;
		}
	}
	
}
	

void Vehicle::binaryRecModel(vector<Vehicle>& car2, string endResult, int lownum, int highnum)
{
	if (highnum > lownum)
	{
		int midnum = (lownum + highnum) / 2;
		if (car2[midnum].getmodel() > endResult)
		{
			return binaryRecModel(car2, endResult, lownum, midnum); //calling the function again - recursive call
		}
		else if (car2[midnum].getmodel() < endResult)
		{
			return binaryRecModel(car2, endResult, midnum, highnum);//calling the function again - recursive call
		}

		else
		{
			cout << "The year is " << car2[midnum].getyear() << "The made by " << car2[midnum].getmake() << "The model of the car is  " << car2[midnum].getmodel() << endl;
			//return midnum;
		}
	}


}
void Vehicle::binaryRecYear(vector<Vehicle>&car2, string endResult, int lownum, int highnum)
{
	if (highnum > lownum)
	{
		int midnum = (lownum + highnum) / 2;
		if (car2[midnum].getyear() > endResult)
		{
			return binaryRecYear(car2, endResult, lownum, midnum); //calling the function again - recursive call
		}
		else if (car2[midnum].getyear() < endResult)
		{
			return binaryRecYear(car2, endResult, midnum, highnum);//calling the function again - recursive call
		}

		else
		{
			cout << "The year is " << car2[midnum].getyear() << "The made by " << car2[midnum].getmake() << "The model of the car is  " << car2[midnum].getmodel() << endl;
			//return midnum;
		}
	}


}
void Vehicle::binaryItrMake(vector<Vehicle>& car2, string endResul)
{
		int midnum, lownum = 0, highnum = car2.size();
		while (highnum >= lownum)
		{
			midnum = (highnum + lownum) / 2;
			if (car2.at(midnum).make == endResul)
			{
				cout << "Ther model of the car is  " << endl;
				cout << car2.at(midnum).model << ", the year is " << endl;
				cout << car2.at(midnum).year << ",  made by " << car2.at(midnum).make << endl;
				return;
			}
			else if (car2.at(midnum).make > endResul)
			{
				highnum = midnum - 1;
			}
			else
			{
				lownum = midnum + 1;
			}
	
		}
}
void Vehicle::binaryItrModel(vector<Vehicle>& car2, string endResult)
{
	int midnum, lownum = 0, highnum = car2.size();
	while (highnum >= lownum)
	{
		midnum = (highnum + lownum) / 2;
		if (car2.at(midnum).model == endResult)
		{
			cout << "Ther model of the car is  " << endl;
			cout << car2.at(midnum).model << ", the year is " << endl;
			cout << car2.at(midnum).year << ",  made by " << car2.at(midnum).make << endl;
			return;
		}
		else if (car2.at(midnum).model > endResult)
		{
			highnum = midnum - 1;
		}
		else
		{
			lownum = midnum + 1;
		}

	}
}
void Vehicle::binaryItrYear(vector<Vehicle>& car2,  int yr)
{
	int midnum, lownum = 0, highnum = car2.size();
	while (highnum >= lownum)
	{
		midnum = (highnum + lownum) / 2;
		if (car2.at(midnum).year == yr)
		{
			cout << "Ther model of the car is  " << endl;
			cout << car2.at(midnum).model << ", the year is " << endl;
			cout << car2.at(midnum).year << ",  made by " << car2.at(midnum).make << endl;
			return;
		}
		else if (car2.at(midnum).year > yr)
		{
			highnum = midnum - 1;
		}
		else
		{
			lownum = midnum + 1;
		}

	}
}
}




string Vehicle::getmake()
{
	return make;
}


string Vehicle::getmodel()

{
	return model;
}


int Vehicle::getyear()
{
	return year;
}