#! /bin/bash

#Ce script doit être appelé de la manière suivante :
# ./multiplications.sh <pseudo>
#Il demande à l'utilisateur d'entrer le résultat d'un produit choisi au hasard.

source ../libsh/lib.sh


reponse="y"
nbPoints=0

while [[ $reponse != "n" ]]
do
	E1=$(rand 1 10)
	E2=$(rand 1 10)
	resultat=$(expr $E1 \* $E2)
	echo "$E1 * $E2 = ?"
	read reponse
	if [[ $reponse == $resultat ]]
	then
		echo "Bonne réponse !"
		nbPoints=$(expr $nbPoints + 1)
	else
		echo "Mauvaise réponse :("
	fi
	echo "Voulez-vous continuer ? (y/n)"
	read reponse
done

nomJeu="multiplications"
ajouterScore $PSEUDO $nbPoints $nomJeu

exit 0;

