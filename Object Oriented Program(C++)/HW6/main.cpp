//Name: Sucharita Das
//CSCI : 2313
//Status: Program running properly

//Include the needed files
#include "Studentlist.h"// declearing header file file in the main function
#include "Studentlist.hpp"
#include "Student.h"// declearing header file file in the main function
#include <iostream>
#include <string>// for string
#include <fstream>// to open a file
#include <istream>
#include <sstream>
#include <cstring>


using namespace std;
//main function 

int main()

{
	List<int> v1;//object declearation
	List<int> v2(3);
	
	//create a pointer to a second list and construct it with the first list.
	//print out second list to show that copy constructor works
	//create a pointer to the third list, then use = to assign it to the first list
	cout << "Pushfront on v1\n";
	v1.push_front(1);
	v1.push_front(2);
	v1.push_front(3);
	v1.print(cout);
	cout << endl;

	List<int> v3(v1);
	cout << "After declaration of V3 based on v1\n";
	v3.print(cout);


	cout << "Pushbacks on v1\n";
	v1.push_back(1);
	v1.push_back(2);
	v1.push_back(3);
	v1.print(cout);
	cout << endl;

    // List<int> v3(v1);
	cout << "After declaration of V3 based on v1\n";
	v3.print(cout);

	cout << "\nChange existing elements and trigger exception\n";
	try
	{
		v1.at(0) = 0;
		v1.print(cout);
		v1.at(10) = 100;
	}
	catch (int e)
	{
		if (e == 0)
			cout << "Array out of Bounds\n";
		else if (e < 0)
			cout << "Negative index\n";
	}
	List<Student>hw1;
	ifstream input;
	ofstream output;
	string name1 = " ", name2 = " ", name3 = " ";
	int i = 1;
	cout << "type three names to be used\n";
	cout << "name: " << i << " ";
	getline(cin, name1);
	i++;
	cout << "name: " << i << " ";
	getline(cin, name2);
	i++;
	cout << "name: " << i << " ";
	getline(cin, name3);

	cout << "\nWriting to binary file\n";
	fstream file;
	//reading the bionary file student.dat
	file.open("student.dat", ios::out | ios::in | ios::binary);
	Student e;
	e.name = " ";
	strcpy_s(e.name, "Ashly");
	e.id = 111;
	file.write((char*)&e, sizeof(Student));

	strcpy_s(e.name, "Jennifer");
	e.id = 222;
	file.write((char*)&e, sizeof(Student));

	strcpy_s(e.name, "avier");
	e.id = 333;
	file.write((char*)&e, sizeof(Student));

	cout << "\nReading from binary file, and adding to employee vector\n";
	List<Student> ve;
	//reset cursor to the beginning of the file
	file.seekg(ios::beg);

	while (file.read((char*)&e, sizeof(Student)))
	{
		ve.push_back(e);
	}
	file.close();
	ve.print(cout);

	char name1Array[20], name2Array[20], name3Array[20];
	/*strcpy(name1Array, name1.c_str());
	strcpy(name2Array, name2.c_str());
	strcpy(name3Array, name3.c_str());*/
	
	Student student1;
	for (int i = 0;i<20;i++)
	{
		student1.name[i] = name1Array[i];
	}
	hw1.push_front(student1);
	hw1.print(cout);
	for (int i = 0;i<20;i++)
	{
		student1.name[i] = name2Array[i];
	}
	hw1.push_front(student1);
	hw1.print(cout);
	for (int i = 0;i<20;i++)
	{
		student1.name[i] = name3Array[i];
	}
	hw1.push_front(student1);
	hw1.print(cout);
	hw1.pop_back();
	hw1.print(cout);
	hw1.pop_front();
	hw1.print(cout);
	hw1.push_front(student1);
	hw1.print(cout);
	hw1.clear();
	hw1.print(cout);


	return 0;
}