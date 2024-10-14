#!/bin/bash
#First line of script that indicate which shell version using
#Task-2
# Using echo to display a massage on the terminial
echo "Welcome to Day 1 of the Bash scripting challenge!"

# Task:3 Variable
# Declaring variables and assigning valu
name="RAM MANDIR"
location="Ayodhya"
year="2024"
#Using echo display variables
echo "Name: $name"
echo "Location: $location"
echo "Year: $year"

#Task 4: Using Variables
#Declaring Two variables "numbers" and calculating their sum
num1=5
num2=4
# Using the expr command to calculating the sum
sum=$(expr $num1 + $num2)
echo "The sum of $num1 and $num2 is:$sum"

# Task 5: Using Built-in Variables
# Built-in variables in bash provide useful system information.
# Let's display some built-ib Variables
#The current loged-in User
echo "Current user: $USER"
#
#The home directory of the current user
#
echo "Home Directory: $HOME"

# Current working directory
#
echo "Current Working Directory: $PWD"


echo "My current bash path - $BASH"
echo "Bash version I am using - $BASH_VERSION"
echo "PID of bash I am running - $$"

# Task 6: Wildcards
#
# List all files in current directory with ".sh" extension
#
echo "List all shell script files in the current directory"
ls *.sh
