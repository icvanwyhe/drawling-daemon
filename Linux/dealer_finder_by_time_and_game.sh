#!/bin/bash

if [ $3 = 'blackjack' ]; then
    grep "$1" $2_Dealer_schedule |  awk -F" " '{print $1, $2, $3, $4 }'
elif [ $3 = 'roulette' ]; then
    grep "$1" $2_Dealer_schedule |  awk -F" " '{print $1, $2, $5, $6 }'
elif [ $3 = 'Texas' ]; then
    grep "$1" $2_Dealer_schedule |  awk -F" " '{print $1, $2, $7, $8 }'
else
    echo 'Incorrect game argument'
fi




