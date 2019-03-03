//Sucharita Das
//Declearing all header file and library which are needed for this program
#include <iostream>
#include "ArrayBag.h"
#include "SetFunctions.h"
using namespace std;
int main()
{
	int r;//variable
	cout << "Starting ......" << endl;
	Set FirstSet, SecondSet;

	ifstream infile("setInput.txt");// Opening the text file where we have 2 sets of numbers

	//Reading  two lines of the numbers into the sets
	FirstSet.fileIn(infile);
	SecondSet.fileIn(infile);

	infile.close();// closing the text file

	//printing out all numbers of set 
	cout << "First Set is:" << FirstSet <<endl;// Display the 1st set of integers 
	
	cout << "Second Set is:" << SecondSet <<endl;// Display the 2st set of integers 
	
	cout << "Union for First and Second Set is " << FirstSet + SecondSet << endl;// printing out all numbers but not duplicate value

	cout << "Difference Set between First Set and Second Set is :" << FirstSet - SecondSet <<endl;//difference between FirstSet and SecondSet
	
	cout << "Difference Set between Second Set and First Set is :" << SecondSet - FirstSet <<endl;//difference between SecondSet and FirstSet
	
	
	cout << "Finshing ......" << endl;
	cin >> r;
}