#!/bin/bash

# sysinfo_page - A script to look up roulette dealer at a specific time.
# example of $1: 02:00:00*PM
# example of $2: 0310

grep -E $1 $2_Dealer_schedule | awk '{print $1 $2 " " $5 " " $6}'
