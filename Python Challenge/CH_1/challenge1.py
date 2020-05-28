# -*- coding: utf-8 -*-
"""
Created on Fri May 22 14:37:57 2020

Name: Abhishek Vasudev Mahendrakar
USN: 4AL17EC003
Student at Alva's Institute of Engineering and Technology.
E-mail: abhi2244mahendrakar@gmail.com
Github: AbhishekVasudevMahendrakar 
"""

# Problem statement: Write python code to verify user_name = "Micheal" and password ="e3$WT89x". The total number of attempts are 03. For every wrong user_name and password Print - Invalid username or Password, upon three attempts fails print- Account locked

# If inputs are correct Print - You have successfully login


user_name= input("Enter user name: ")
password= input("Enter password: ")
         
for i in range(3):
    if user_name == 'Micheal' and password == 'e3$WT89x':
        print("You have successfully login")
        break
    elif i==2:
        print("Account locked!")
        break
    else:
        print("Wrong Username or password. Please try again!!!")
        user_name= input("Enter user name: ")
        password= input("Enter password: ")
        