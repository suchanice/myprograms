#include <unordered_map>
#include <iostream>
#include <fstream>
#include "DataSet.h"

using namespace std;
#ifndef MenuDisplay_H
#define MenuDisplay_H
/*For menu system display */
class MenuDisplay {
private:
    /* Input stream to read menu commands from   */
    istream &in;
    /*Output stream to write menu messages to    */
    ostream &out;
    /* map of DataSet names to DataSets; all of the data we know about  */
    unordered_map<string, DataSet> db;
    /* initialized in constructor   */
    vector<string> DataSetNames;
public:
    /*Constructor   */
    MenuDisplay(istream &in, ostream &out);
    /*Boolean to continue main menu or stop    */
    bool rootMenu();
    /*Loop through the menu   */
    void loop();
    /*Load from CDV, sets value in this->db to the contents of a new CSV file with a file name    */
    void loadfromcsv(string name, string path);
    /*select DataSet method to choose the DataSet name    */
    string selectDataSet();
    /*Print row method to print the row    */
    void printRow(vector<string> titles, unordered_map<string, string> row);
    const unordered_map<string, DataSet> &getDb() const;
    void loadfiles();
    /*Prompt user to load database from files    */
    void addrecord();
    /* Prompts user for DataSet then fields then finds a row  */
    void findrecord();
    /*Prompts user for DataSet then fields then finds a row and then modify*/
    void modifyrecord();
    /*Prompts user to delete record from a file in database  */
    void deleterecord();
    /* Prompt to sort a DataSet by field*/
    void sortrecord();
    /**Prompts user to search user for partial match from all 3 files*/
    void partialsearchrecord();
    /*Prompts user to write data in DataSet*/
    void writerecord();
	void displaydata();
};
#endif 
