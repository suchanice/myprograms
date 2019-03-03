//Sucharita Das
//HW7
//Includeing all header file
#ifndef data_h
#define data_h
#include <stdexcept>
#include <string>
using namespace std;

class Data : public logic_error
{

public:
	
	Data(const string& message = "");//default constructor
};
#endif