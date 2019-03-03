//Sucharita Das

#include <cstdlib>
#include <iostream>
#include "function.h"

using namespace std;

void Guess::numberanalysis() 
{
	cout << "Enter a range value: ";// asking for user input to get range
	cin >> m;//read the input value
	cout << "How many number you want to guess ? ";//asking for user input 
	cin >> n;//read the input value
	guess = new int[n];//geting the number and putting into the array
	populatenewnumbers(m, n);
}

int Guess::GenerateRandnum(int m) //function to get randam number
{
	return rand() % m + 1;
}
void Guess::populatenewnumbers(int m, int n)
{
	for (int i = 0; i < n; i++) {
		guess[i] = GenerateRandnum(m);//geting the random number and string into the array
		//cout << "Random number is :" << guess[i] << endl;

	} cout << endl;
}
bool Guess::UserGuess() 
{
	int *temp = new int[n];
	char option;
	cout << "Enter your guesses: " <<   endl;//asking for user input. Please enter the number by pressing enter

	for (int i = 0; i<n; i++) //
	{

		cin >> temp[i];
	}
	
	int count = 0;
	for (int i = 0; i<n; i++) {
		for (int j = 0; j<n; j++) {
			
			if (guess[i] == temp[j]) //compair the number which are in the array
			{
				
				count++;
				break;
			}
		}
	}
	delete[] temp;
	//If want to play more otherwise exit from the game
	if (count == n) {
		cout << "You are correct!" << endl;
		cout << "Press N to exit :";
		cin >> option;
		if (option == 'N' or option == 'n')//asking for user input if he want to play or not
			exit;

		delete guess;//delete the array
		return true;
	}
	else {
		cout << count << " of your guesses are correct." << endl;//if the user's guess is currect 
		return false;
	}


}
