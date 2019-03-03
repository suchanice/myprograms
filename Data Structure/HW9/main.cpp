//Sucharita Das
//HW9
//SellingCheck function
//Declearing all library

#include <iostream>
#include <string>
#include <fstream>//to read the file
#include <sstream>
#include <string>
#include <ctime>
#include <stdlib.h>
#include <algorithm>
#include "hash.h" //calling .h file

using namespace std;


hashTable dictionary(100000);
int linecount = 0;

void load_dict(ifstream &fdict) 
{
	string line;
	while (getline(fdict, line))
	{
		transform(line.begin(), line.end(), line.begin(), ::tolower);//boost::algorithm::to_lower(line);
		dictionary.insert(line);
	}
}

void spell_check(ifstream &fin, ofstream &fout)//spelling check function
{

	string line, word, tmp;
	int i, c, isDigit;
	int line_num = 1;

	while (getline(fin, line)) {

		transform(line.begin(), line.end(), line.begin(), ::tolower);		//boost::algorithm::to_lower(line);
		for (i = 0; i < line.size(); i++) 
		{
			c = (int)line[i];
			if ((c == 32) || (c == 39) || (c == 45) || ((c > 47) && (c < 58)) || ((c < 123) && (c > 96)))//compaireing all 
				;
			else
				line[i] = ' ';
		}

		stringstream ss(line);
		while (ss >> word) {

			isDigit = 0;
			for (i = 0; i < word.size(); i++) {
				c = (int)word[i];
				if ((c > 47) && (c < 58))
					isDigit = 1;
			}

			if (word.size() > 20)
				fout << "Long word at line " << line_num << ", starts: " << word.substr(0, 20) << endl;
			else if (dictionary.contains(word) == true || isDigit);
				else
				fout << "Unknown word at line " << line_num << ": " << word << endl;//compair if there are unknown word
			
		}
		line_num++;//countion one by one
	}

}
//main function
int main() 
{

	string tmp, tmp1, tmp2;
	int k;
	string word, word1, word2;
	int count = 0;
	int count1 = 0;
	int count2 = 0;
	cout << "Enter name of dictionary: ";//enter the name of the dictionary which is dict.txt
	cin >> tmp;
	ifstream fdict(tmp.c_str());
	if (!fdict) {
		cerr << "Error: could not open: "  << endl << endl;//if error occure then cannot open the file
		exit(1);
	}
	
	load_dict(fdict);
	fdict.close();

	cout << "Enter name of input file: ";//entering the input file which is check.txt. need to write the name in program
	cin >> tmp1;
	ifstream fin(tmp1.c_str());
	if (!fin) {
		cerr << "Error: could not open: "  << endl;
		exit(1);
	}


	
	cout << "Enter name of output file: ";//entering the output file which is write.txt. need to write the name in program
	cin >> tmp2;
	ofstream fout(tmp2.c_str());//writting in the file
	if (!fout) {
		cerr << "Error: could not open: "   << endl;//if error occure then cannot open the file
		exit(1);
	}

	

	spell_check(fin, fout);

	
	
	fin.close();//closing the file
	fout.close();

	ifstream fdict1(tmp.c_str());
	while (!fdict1.eof())
{
	fdict1 >> word;
	count++;
}
cout << "Number of words in dictionary is " << count << endl;
	fdict1.close();
	
	ifstream fin1(tmp1.c_str());//opening the file to read it
	while (!fin1.eof())
	{
		fin1 >> word1;
		count1++;
	}
	cout << "Number of words in check file is " << count1 << endl ;//cehck how many no. are there
	fin1.close();//closing the file


	ifstream file(tmp2);//opening the file
	while (getline(file, word2))
		count2++;
	cout << "Numbers of wrong or unknown words wrote in the file is : " << count2 << endl;//compaire and write in the output file
	
	cin >> k;
	return 0;
}
