// Sucharita Das
//CSCI 2421
//Guess random number where geting input from user

#include <iostream>//declering all library
#include "function.h"
#include <cstdlib> // for rand function

using namespace std;


int main()
{

	Guess guess;// declering object
	while (true)
	{
		guess.numberanalysis();// calling the function from function.cpp
		while (true) {
			if (guess.UserGuess())// calling the function from function.cpp
				break;
		}
		break;
	}
}