
"""
Spyder Editor
 python script to create new file taking parameter and running the batch file which location is also parameter. 
putting the python comands in a list then running parallal load. 1st it will run 1st node and all command will run together
then which batch is in the queue that will run agter 30 sceonds later. Then will create all file one by one. how many parallal 
file will run it will depends on user input 

"""
import sys
from multiprocessing import Queue
from subprocess import call
from multiprocessing import Pool


with open(sys.argv[1]) as file: #for the first argument 
    lines = [line.strip() for line in file]
#print(lines)
count=len(lines) #Total number of the file need to make from batch file
#print("Print total count : ",count)
queue = Queue()
cnt1 = sys.argv[2::2]  #for the 2nd argument
cnt = int(cnt1[0])
listno = list(range(count))
print(listno)

#This code is from the following webside
#https://www.journaldev.com/15631/python-multiprocessing-example
def work_log(i):  
    queue.put(call(lines[i]))
    print(lines[i])


if __name__ == '__main__':
    p = Pool(cnt)
    p.map(work_log,listno)
    
