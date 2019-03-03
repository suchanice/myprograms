//Sucharita Das

#include<iostream>
#include<fstream>
#include"ArrayBag.h"

class Set//declearing set class
{
private:
	ArrayBag SetArray;

public:
	Set();

	bool addition(const int newValue);//add number to the each set
	bool remove(const int rmValue);//remove number from the set
    bool fileIn(std::ifstream& infile);//read from file
    friend Set operator+(const Set a, const Set b);// friend function and  this is for Union function
	
	//Asymmetrical difference of sets
	friend Set operator-(const Set a, const Set b);

	//Display the set on the console
	friend std::ostream& operator<<(std::ostream &os, const Set output);
};

Set operator+(const Set a, const Set b);// overloading + oparator
Set operator-(const Set a, const Set b);//Overloading _ oparator

std::ostream& operator<<(std::ostream &os, const Set output);
