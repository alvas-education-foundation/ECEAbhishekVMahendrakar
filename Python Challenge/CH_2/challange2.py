# -*- coding: utf-8 -*-
"""
Created on Thu May 28 19:36:14 2020

Name: Abhishek Vasudev Mahendrakar
USN: 4AL17EC003
Student at Alva's Institute of Engineering and Technology.
E-mail: abhi2244mahendrakar@gmail.com
Github: AbhishekVasudevMahendrakar 
"""
import pandas as pd

import matplotlib.pyplot as plt
import csv

x=[]
y=[]

with open('a01_3.csv', 'r') as csvfile:
    plots= csv.reader(csvfile, delimiter=',')
    for row in plots:
        x.append((row[0]))
        y.append((row[1]))


plt.plot(x,y, marker='o')

plt.title('ECG Signal')

plt.xlabel('Time')
plt.ylabel('Raw_ECG')
plt.xlim(500,520)
plt.ylim(20,400)

plt.show()