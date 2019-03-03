#Name: Sucharita Das
#Class: CSCI 2312
#Include the files
#This program will read csv file of each animal and print out name, color, habitant , prediator ext

import csv
import os

 
# Define the paths and files
pathDog = "Dog.csv"
pathFish = "Fish.csv"
pathHorse = "Horse.csv"
pathLizard = "Lizard.csv"
pathMonkey = "Monkey.csv"
 
# Dog details of the program
class dog:
      try:
          
          def printdog():
            fileDog= open(pathDog,newline='')
            readerDog=csv.reader(fileDog)   #function for reading name from file          
            for row in readerDog:
                Name=row[0]#read the name from file
                Breed=row[1]#read breed from csv file
                Age=float(row[2])#read age from file
                Color=row[3] #function for reading color from file

                Weight=float(row[4])  
             
                print("********************************************")
                print("The Dog Details from the files are :")# print all the details to read the file 
                print("Name : " + Name)
                print("Color : " + Color)
                print("Weight : " + str(Weight))
                print("Breed : " + Breed)
                print("Age : " + str(Age))
                print("New Weight : " + str(Weight - 10))#function for reduce 10 pound weight from dog's original weight
                print("********************************************")
 
      except IOError:
              print ("Could not read file:", fileDog) #exception handleling if file will not open will trough output that could not read the file
              sys.exit()
 
# Fish details of the program
 
class Fish:
    try:
    
        def printFish():
            fileFish= open(pathFish,newline='')#opening csv file
            readerFish=csv.reader(fileFish)
 
            for row in readerFish:#read all details from csv file
                Name=row[0]
                Color=row[1]
                if row[2] == "FALSE":#look if the fish is from freshwater or not
                    FreshWater="Non-freshwater Fish"
                else:
                    FreshWater="Freshwater Fish"
                Habitat=row[3]
                if row[4] == "FALSE":#look for fish is prediator or not
                    Predator ="Non Predatory Fish"
                else:
                    Predator ="Predatory Fish"        
                print("The Fish Details from the files are :")# print all the details to read the file 
                print("Name : " + Name)
                print("Color : " + Color)
                print("Freshwater : " + FreshWater)
                print("Habitat : " + Habitat)
                print("Predator : " + Predator)
                print("********************************************")
 
    except IOError:
        print ("Could not read file:", fileFish)#exception handleling if file will not open will trough output that could not read the file
        sys.exit()
 
# Horse details of the program
 
class Horse:
    try:
        def printHorse():
            fileHorse= open(pathHorse,newline='')#open the csv file
            readerHorse=csv.reader(fileHorse)
 
            for row in readerHorse:#read all details from csv file
                Name=row[0]#read name from file
                Color=row[1]#read color from file
                ManeColor=row[2]
                Age=float(row[3])#reading age from file
                Height=float(row[4])  
                if float(row[4]) > 1:
                    NewHeight = float(row[4]) + 1#incresing horse's height 1 m.
                print("The Horse Details from the files are :")# print all the details to read the file 
                print("Name : " + Name)
                print("Body Color : " + Color)
                print("Mane Color : " + ManeColor)
                print("Age : " + str(Age))
                print("Height : " + str(Height))
                print("New Height : " + str(NewHeight))
                print("********************************************")
 
    except IOError:
        print ("Could not read file:", fileHorse) #exception handleling if file will not open will trough output that could not read the file
        sys.exit()
 
# Monkey details of the program
 
class Monkey:
    try:
        def printMonkey():
            fileMonkey= open(pathMonkey,newline='')#open the csv file 
            readerMonkey=csv.reader(fileMonkey)
 
            for row in readerMonkey:#read all details from csv file
                Name=row[0]
                Color=row[1]
                Age=float(row[2])
                if row[3] == "TRUE":#look for monkey is wild or not
                    Wild="Wild Monkey"
                else:
                    Wild="Non-Wild Monkey"
                Home=row[4]
                if row[5] == "FALSE":#look for the monkey is endengered or not
                    Endangered="Endangered Monkey"
                else:
                    Endangered="Non-Endangered Monkey"
                print("The Monkey Details from the files are :")# print all the details to read the file 
                print("Name : " + Name)
                print("Color : " + Color)
                print("Age : " + str(Age))
                print("Wild : " + Wild)
                print("Home : " + Home)
                print("Endangered : " + Endangered)
                print("********************************************")
 
    except IOError:
        print ("Could not read file:", fileMonkey) #exception handleling if file will not open will trough output that could not read the file
        sys.exit()
 
 
# Lizard details of the program
class Lizard:
   try:
     def printLizard():
        fileLizard= open(pathLizard,newline='')#opening csv file
        readerLizard=csv.reader(fileLizard)
 
        for row in readerLizard:#read all details from csv file
            Name=row[0]
            Color=row[1]
            Habitat=row[2]
            if row[3] == "FALSE":
                Proetected="Non-Proetected Lizard"#look for the lizard is protected or not
            else:
                Proetected="Proetected Lizard"
            Weight=float(row[4])        
            print("The Lizard Details from the files are :")# print all the details to read the file 
            print("Name : " + Name)
            print("Color : " + Color)
            print("Habitat : " + str(Habitat))
            print("Proetected : " + Proetected)
            print("Wight : " + str(Weight))
            print("********************************************")
 
   except IOError:
        print ("Could not read file:", fileLizard)  #exception handleling if file will not open will trough output that could not read the file
        sys.exit()
 
 #all call print function to show all details
dog.printdog()#call dog print function and show all details
Fish.printFish()#call fish print function and show all details
Horse.printHorse()#call horse print function and show all details
Monkey.printMonkey()#call monkey print function and show all details
Lizard.printLizard()#call lizard print function and show all details