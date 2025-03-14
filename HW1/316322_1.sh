#!/bin/bash

function winner() {

	if [[ $user == $computer ]]; then
		echo "Tie!"
		return 1
	elif [[ ($user == "rock" && $computer == "scissors") || ($user == "scissors" && $computer == "paper") ||($user == "paper" && $computer == "rock") ]]; then
		echo "You Win! $user beats $computer"
		return 0
	else
		echo "Computer Wins! $computer beats $user"
		return 2
	fi	
}

function rules() {
	echo -e  "Greetings! Welcome to Rock, Paper, Scissors\n"
	echo -e "The rules are as follows: \n\ta) Rock beats scissors by crushing them \n\tb) Scissor beat paper by cutting it \n\tc) Paper beats rock by covering it \n"
}

while true; do
	rules
	read -p "Rock, Paper, or Scissors: " user
	sleep .5
	options=("rock" "paper" "scissors")
	computer=${options[$RANDOM % 3]}
	echo -e "\nComputer chose: $computer \n"

	winner
	result=$?

	sleep .5

	if [ $result -ne 1 ]; then
		break
	else
		echo -e "Rematch! \n"
	fi
done

echo "Game Over!"
