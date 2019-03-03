//Sucharita Das
//Data Structure Homework 6
#include <string>
#include <list>
#include <iostream>
#include <fstream>
#include <sstream>
#include <cstring>

#include "DicEntry.h"
using namespace std;

int main() 
{
	int k;
	FILE *filepointer= freopen("dictionary.txt", "r", stdin);

	// fill the word list from file
	list<DicEntry> Listofwords;
	wordType word;
	
	while (cin >> word)
	{
		DicEntry* newDictEntryObj = new DicEntry();//declearing object
		newDictEntryObj->setaWord(word);
		// add it to list
		Listofwords.push_back(*newDictEntryObj);
	}
	fclose(filepointer);//closing the file dictionary.txt
	Listofwords.sort();

	
	ifstream infile;//opening the findwords.txt file
	infile.open("findwords.txt", ifstream::in);
	while (infile >> word)
	{	int forwardCnt = findFront(Listofwords, word);
		int backwardCnt = findEnd(Listofwords, word);
		if (forwardCnt == -1 || backwardCnt == -1) 
		{
			cout << "cannot find words" << endl;
			DicEntry* newDictEntryObj = new DicEntry();
			newDictEntryObj->setaWord(word);
			Listofwords.push_back(*newDictEntryObj);
			Listofwords.sort();
		}
		else 
		{
			cout << "Output: " << word << endl;//output after running the functions
			cout << "Count from back: " << forwardCnt << endl;
			cout << "Count from back : " << backwardCnt << endl;
			cout << endl;
			
		}
		
	}
	
	infile.close();//closing the file findwords.txt

	filepointer = freopen("revsorted.txt", "w", stdout);//we can point the file and we can see the data in the file
	reverseList(cout, Listofwords);
	fclose(filepointer);
	system("PAUSE");
	cin >> k;
    

}
