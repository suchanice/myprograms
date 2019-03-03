//Sucharita Das
//StudentId : 109103020
//CSCI: Data Structure
#include <iostream>
#include "MyVector.h"

using namespace std;

int main()
{
	//first, let's define a vector
	HW4::MyVector vect;
	int k;
	//now, let's start adding values to the vector using our own push back function
	cout << "The size of the Vector is " << vect.size() << endl;
	cout << "Let's add some data to it " << endl;
	for (int j=0; j < 10; j++)
	{
		vect.push_back(j + 20); //adding data from 20-29 using our push back function
		//cout << "Vector position for value added is " << j << endl; //Vector position for value added
	}
	cout << "Now, let's display the vector" << endl;
	for (int j = 0; j < 10; j++)
	{
		cout << "The Vector position is " << j << " and the value is " << vect[j] << endl;
	}
	cout << "Let's find the size of the vector using our function " << endl; //Let's find the size of the vector using our function

	cout << "The size of the Vector is " << vect.size() << endl;

	cout << "Let's add one more value" << endl; //Let's add one more value

	vect.push_back(30);

	cout << "Let's disply the vector one more time" << endl; //Let's disply the vector one more time

	for (int j = 0; j < vect.size(); j++)
	{
		cout << "The Vector position is " << j << " and the value is " << vect[j] << endl;
	}
	cout << "Now, the size of the Vector is " << vect.size() << endl; //To get  the size of the Vector
	cout << "Now, let's see how pop back works!" << endl;

	vect.pop_back();
	cout << "Now, the size of the Vector is " << vect.size() << endl; //the size of the Vector

	cout << "Let's disply the vector after the pop back" << endl; //after the pop back

	for (int j = 0; j < vect.size(); j++)
	{
		cout << "The Vector position is " << j << " and the value is " << vect[j] << endl;
	}

	cout << "Let's check search function" << endl; //search function

	cout << "The position for number 7 in the vector is " << vect.search(7) << endl;

	
	cout << "Let's do two more pop backs" << endl;
	vect.pop_back();
	vect.pop_back();
	
	cout << "Let's check if the vector is empty using our function" << endl;
	cout << "Is the vector empty ? The answer is  :" << vect.empty() << endl;

	//Now, let's really empty the vector and test this function
	cout << "Now, let's really empty the vector and test this function" << endl;

	for (int j = 0; j < vect.size(); j++)
	{
		vect.pop_back();
	}

	cout << "Let's check if the vector is empty using our function" << endl;
	cout << "Is the vector empty ? The answer is  :" << vect.empty() << endl;
	cout << "All the custom function written on vector, is verified now successfully !";
	cin >> k ;
}