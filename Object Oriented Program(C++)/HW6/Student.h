//Name: Sucharita Das
//Include the files
#ifndef STUDENT_H
#define STUDENT_H
#include <iostream>
#include <string>

using namespace std;
struct Student //
{

	char name[20];//string veriable
	int id;//integer veriable


};
std::ostream& operator << (std::ostream &out, Student e)
{
	out << e.name << "\t" << e.id;
	return out;
}
#endif

