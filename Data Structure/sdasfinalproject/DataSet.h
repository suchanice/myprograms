#include <vector>
#include <unordered_map>
#include "BSTree.hpp"
#include <iostream>
#include <sstream>
#include <string>
//#include "csv.h"
using namespace std;
#ifndef DataSet_H
#define DataSet_H
//initializing dataset class
class DataSet {
private:
    vector<string> titles;
    vector<unordered_map<string, string>> rawData;
    unordered_map<string, BSTree<unordered_map<string, string>, string>*> indexedData;
public:
    DataSet() {} //constructor
	//all public methods
    DataSet(vector<string> titles, vector<unordered_map<string, string>> rawData);
    unordered_map<string, string> findByValue(string columnValue, string cellValue);
    unordered_map<string, string> findByPartialValue(string columnValue, string cellValue);
    void removeByValue(string columnValue, string cellValue);
    void replaceByValue(string columnValue, string cellValue,unordered_map<string, string> row);
    void printInOrderBy(string key);
    void add(unordered_map<string, string> row);
    const vector<string> &getTitles() const;
    void writeDataSet(ostream &out);
	void writedata();
};
DataSet readDataSet(istream &in);
pair<vector<string>, vector<unordered_map<string, string>>> csvreadfunction(istream &in);
void writeMapsAsCsv(ostream &out, vector<string> titles, vector<unordered_map<string, string>> DataSet);
void writedatascreen(vector<string> titles, vector<unordered_map<string, string>> DataSet);
#endif //DataSet_H
