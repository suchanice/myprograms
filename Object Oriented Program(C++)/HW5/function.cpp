//Name: Sucharita Das
#include "function.h"
#include <string>
#include <iostream>
using namespace std;

Animal::Animal()
{
}
Animal::Animal(int age, int weight, int height, string color, string name, string breed)
{
	
}
//................................................................................
void Animal :: setName(string newName)
{
	name = newName;
}
string Animal::getName()//function for reading name from file
{
	return name;
}

void Animal::setColor(string newColor)
{
	color = newColor;
}
string Animal::getColor()//function for reading color from file
{
	return color;
}

int Animal::getAge()////function for reading age from file
{
	return age;
}
void Animal::setAge(int newAge)
{
	age = newAge;
}




//....................................................................................
//Functions for Dog
int Dog::getubtract10()//subtruct 10 pround from dog's original weight
{
	if (weight > 10)
		weight -= 10;
	return weight;
}
void Dog::setubtract10(int newWeight)
{
	weight = newWeight;

}

string Dog::getBreed()
{
	return breed;
}
void Dog ::setBreed(string newBreed)//  function to show dog's breed
{
	breed = newBreed;
}

//void subtract10(int weight)//subtruct 10 pround from dog's original weight
//{
//	if (weight > 10) 
//		weight -= 10;
//		
//}

void  Dog::print()
// Call the print functions
{

	cout << "***************************************" << endl;
	cout << "The Dog Details from the files are : " << endl;
	cout << "Name : " << getName() << endl;
	cout << "Color : " << getColor() << endl;
	cout << "Weight : " << weight << endl;
	cout << "Breed : " << breed << endl;
	cout << "Age : " << getAge()<< endl;
	cout << "New Weight : " << getubtract10() << endl;
	cout << "***************************************" << endl;
}

//....................................................................................
//Functions for Fish
string Fish::getHabitat()
{
	return habitat;
}

void Fish::setHabitat(string newHabitat)//This function shows that what is fish's habitat
{
	habitat = newHabitat;
}

string Fish::getFreshwater()
{
	return freshwater;
}

void Fish::setFreshwater(string newFreshwater)//this function is for fish lives in fresh water not
{
	if (newFreshwater == "TRUE" || newFreshwater == "true")
		newFreshwater = "Freshwater Fish";
	else
		newFreshwater = "Non-freshwater Fish";
	freshwater = newFreshwater;
}

string Fish::getPredator()
{
	return Predator;
}

void Fish::setPredator(string newPredator)//This function is for fish is predator or not
{
	if (newPredator == "TRUE" || newPredator == "true")
		newPredator = "Predatory Fish";
	else
		newPredator = "Non Predatory Fish";
	Predator = newPredator;
}

void  Fish::print()
// Call the  print functions
{
	
	cout << "***************************************" << endl;
	cout << "The Fish Details from the files are : " << endl;
	cout << "Name : " << getName() << endl;
	cout << "Color : " << getColor() << endl;
	cout << "Freshwater : " << getFreshwater() << endl;
	cout << "Habitat : " << getHabitat() << endl;
	cout << "Predator : " << getPredator() << endl;
	cout << "***************************************" << endl;
}
//......................................................................................



//Functions for Horse
string Horse::getManeColor()
{
	return maneColor;
}

void Horse::setManeColor(string newManeColor)// this function is for to show maincolor
{
	maneColor = newManeColor;
}

void Horse::setadd1 (int newHeight)
{
height = newHeight;

}

int Horse::getadd1()// adding 1 hand height with previous horse's height
{
	if (height > 1)
		height += 1;
	return height;
}

void  Horse::print()// call all Horse Details from the file
{
	cout << "***************************************" << endl;
	cout << "The Horse Details from the file are : " << endl;
	cout << "Name : " << getName() << endl;
	cout << "Body Color : " << getColor() << endl;
	cout << "ManeColor : " << getManeColor() << endl;
	cout << "Age : " << getAge() << endl;
	cout << "Height : " << height << endl;
	cout << "New Height :" << getadd1() << endl;
	cout << "***************************************" << endl;
	
}

//.............................................................................
//Functions for Monkey
string Monkey::getWild()
{
	return wild;
}

void Monkey::setWild(string newWild)// This function is for monkey is wild or not
{
	if (newWild == "TRUE" || newWild == "true")
		newWild = "Wild Monkey";
	else
		newWild = "Non Wild Monkey";
	wild = newWild;
}

string Monkey::gethome()
{
	return home;
}

void Monkey::sethome(string newHome)//This function is for where monkey lives
{
	home = newHome;
}

void Monkey::setchangeEndangered(string newEndangered)//This function will read Monkey is endangered or not 
{
	if (newEndangered == "TRUE" || newEndangered == "true")
		newEndangered = "Non Endangered Monkey";
	else
		newEndangered = "Endangered Monkey";
	endangered = newEndangered;
}


string Monkey::getchangeEndangered()
{
	return endangered;
	//endangered= newEndangered;

}


void  Monkey::print()
// Calls the print function
{
	
	cout << "***************************************" << endl;
	cout << "The Monkey Details from the files are : " << endl;
	cout << "Name : " << getName() << endl;
	cout << "Color : " << getColor() << endl;
	cout << "Age : " << getAge() << endl;
	cout << "wild : " << getWild() << endl;
	cout << "Home : " << gethome() << endl;
	cout << "Endangered :  " << getchangeEndangered() << endl;
	cout << "***************************************" << endl;
}


//............................................................................
//Functions for Lizard
string Lizard::getHabitat()
{
	return habitat;
}

void Lizard::setHabitat(string newHabitat)// read from file what is the habitat of lizard
{
	habitat = newHabitat;
}

int Lizard::getWeight()
{
	return weight;
}
void Lizard::setWeight(int newWeight)
{
	weight = newWeight;
}

string Lizard::getProtected()
{ return Protected;
}

void Lizard::setProtected(string newProtected)// This function will read that Lizard is protected or not
{
	if (newProtected == "TRUE" || newProtected == "true")
		newProtected = "Protected Lizard";
	else
		newProtected = "Non Protected Lizard";
	 Protected=newProtected;

}

void  Lizard::print()
// Calls the base class print function
{
	
	cout << "***************************************" << endl;
	cout << "The Lizard Details from the files are : " << endl;
	cout << "Name : " << getName() << endl;
	cout << "Color : " << getColor() << endl;
	cout << "Habitat : " << getHabitat() << endl;
	cout << "Protected : " << getProtected() << endl;
	cout << "Weight : " << getWeight() << endl;
	cout << "***************************************" << endl;
}