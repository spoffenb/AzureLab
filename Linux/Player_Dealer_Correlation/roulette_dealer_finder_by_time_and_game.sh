#!/bin/bash
#This script is to look up a roulette dealer by time and game
# example of $1: 02:00:00*PM
# example of $2: 0310
# please use the following for $3 depending on which game you would like to look up:
	#For blackjack: 1
	#For Roulette: 2
	#For texas hold em: 3

grep -E $1 $2_Dealer_schedule |
	if [ $3 -eq 1 ]
	then
		awk '{print $1 $2 " " $3 " " $4}'
	elif [ $3 -eq 2 ]
	then
		awk '{print $1 $2 " " $5 " " $6}'
	elif [ $3 -eq 3 ]
	then
		awk '{print $1 $2 " " $7 " " $8}'
	fi
