
#include <fstream> //file input
#include <sstream> //stringstream
#include <string> //read from file to string
#include "ArrayBag.h"
#include "SetFunctions.h"
using namespace std;

Set::Set()
{
	SetArray = ArrayBag();
}// default constructor function

bool Set::addition(int newValue)
{
	if (!SetArray.contains(newValue))
		return SetArray.addition(newValue);

	//this function is for  keep consistent with the return value of the ArrayBag class
	if (SetArray.getCurrentSize() < SetArray.TotalSize())
		return true;

	else
		return false;
} // This function is for addition

bool Set::remove(int rmValue)
{
	return SetArray.remove(rmValue);
}// this is remove function

bool Set::fileIn(ifstream& infile)
{
	stringstream ss;
	int storage;
	string reader;

	getline(infile, reader);//read the file
	ss << reader;

	while (!ss.eof())
	{
		ss >> storage;
		addition(storage);//adding to the array

	}
	return true;
}//This is filein function

Set operator+(const Set a, const Set b)
{
	Set sum;
	for (int i = 0; i < a.SetArray.getCurrentSize(); i++)
		sum.addition(a.SetArray[i]);
	for (int i = 0; i < b.SetArray.getCurrentSize(); i++)
		sum.addition(b.SetArray[i]);

	return sum;
}//oparator loverloading + function.add all elements from both sets but not print out duplicate data

Set operator-(const Set a, const Set b)
{
	Set diff;
	//add all the elements of the first set
	for (int i = 0; i < a.SetArray.getCurrentSize(); i++)
		diff.addition(a.SetArray[i]);
	//then remove all of the elements from the second
	for (int i = 0; i < b.SetArray.getCurrentSize(); i++)
		diff.remove(b.SetArray[i]);

	return diff;
}//oparator loverloading - function. Print all the elements of the first set then remove all of the elements from the second

std::ostream& operator<<(std::ostream &num, const Set output)
{
	for (int i = 0; i < output.SetArray.getCurrentSize(); i++)
		num << output.SetArray[i] << '\t';
	return num;
}