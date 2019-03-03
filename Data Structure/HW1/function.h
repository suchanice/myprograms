// Sucharita Das
#ifndef FUNCTION_H
#define FUNCTION_H
#include <cstdlib>

class Guess //Declering guess class
{
public:
	Guess() //default constructor
	{
		n = 0;//declering variable
		m = 0;
	}
	void numberanalysis();
	bool UserGuess();
private:
	int n, m;//declering private variable
	int *guess;
	int GenerateRandnum(int m);
	void populatenewnumbers(int m, int n);
};
#endif
