#! /bin/bash


source lib.sh

# 3 arguments

if [ $# -ne 3 ]
then
	echo "Il faut 3 arguements .. quizz.sh <cheminFic> <numColQ> <numColR>!"
	exit 1
fi

# Le fichier existe-t-il ?

if [ ! -f $1 ]
then
	echo "Le fichier $1 n'existe pas !"
	exit 2
fi




# numéros des colonnes correcte

# on considère la première ligne

firstLigne=`head -n 1 $1`

#echo $firstLigne

nbcols=`echo $firstLigne | sed "s/:/ /g" | wc -w` #eqv => nbcols=`echo $firstLigne | tr ":" " " | wc -w`
#echo $nbcols

# <numColQ>

if [ $2 -lt 0 -o $2 -gt $nbcols ]
then
	echo "La colonne $2 n'existe pas .."
	exit 3
else
	echo "La colonne $2 existe .."
fi

if [ $3 -lt 0 -o $3 -gt $nbcols ]
then
	echo "La colonne $2 n'existe pas .."
	exit 4
else
	echo "La colonne $3 existe .."
fi

nomQ=`echo $firstLigne | cut -d ":" -f $2 | sed "s/[^a-zA-Z]$//"`
nomR=`echo $firstLigne | cut -d ":" -f $3 | sed "s/[^a-zA-Z]$//"`

echo colQ = $nomQ -- colR = $nomR


echo "--------------------------JEU QUIZZ-----------------------------"

#nb Ligne max

max=`nbLigne $1`
#echo $max
random=`rand 2 $max`
#echo $random

ligne=`nieme $random $1`
#echo $ligne

question=`echo $ligne | cut -d ":" -f $2 | sed "s/[^a-zA-Z]$//"`
reponse=`echo $ligne | cut -d ":" -f $3 | sed "s/[^a-zA-Z]$//"`

#echo $question : $reponse

echo "La $nomR du $nomQ $question est ?"
read rep	# rep est la réponse du l'utilisateur

test=`echo $reponse | grep -i "^$rep$"`
#echo $test
if [[ $test != "" ]]
then
	echo "ok"
else
	echo "ko"
fi

# Fin du jeu 

echo "--------------------------FIN DU JEU-----------------------------"

exit 0





