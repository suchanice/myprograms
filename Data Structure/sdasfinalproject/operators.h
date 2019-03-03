#include <iostream>
#include <unordered_map>
#include "Node.h"
using namespace std;
//operators functions
#ifndef OPERATORS_H
#define OPERATORS_H
ostream &operator<< (ostream &out, unordered_map<string, string> row);
ostream &operator<< (ostream &out, const GeneralData &data);
#endif 
