# Pas de " /bin/bash" en 1ere ligne 
# Pour utiliser cette librairie, faire appel à la commande source <cheminLIbrairie>

#Appel à faire : rand <min> <max>
#renvoie un entier aléatoire compris entre <min> et <max>
#<min> et <max> doivent être positifs.
rand()
{
	if [ $# -lt 2 ]
	then
		echo "Il faut 2 arguments pour cette fonction." >&2
		exit 1
	elif [[ $1 != +([0-9]) ]] || [[ $2 != +([0-9]) ]]
	then
		echo "Les deux arguments doivent être positifs ou nuls." >&2
		exit 2
	elif [ $1 -ge $2 ]
	then
		echo "Le 1er argument doit être strictement inférieur au 2e argument." >&2
		exit 3
	fi
	resultat=`expr $RANDOM \% \( $2 + 1 - $1 \) + $1`
	echo $resultat
}

#Appel à faire : fileLines <fic>
#renvoie le nombre de lignes du fichier en argument.
#<fic> est un fichier
fileLines()
{
	if [ -e $1 ]
	then
		cat $1 | wc -l
	else
		echo "Le fichier $1 n'existe pas." >&2
		exit 1
	fi
}

#Appel à faire : fileLines <numLine> <fic>
#renvoie la ligne <numLine> du fichier <fic>
#<numLine> est un numéro de ligne
#<fic> est un fichier
grepLine()
{
	if [ ! -e $2 ]
	then
		echo "Le fichier $2 n'existe pas." >&2
		exit 1
	fi

	if [[ $1 != +([0-9]) ]]
	then
		echo "Le 1er argument doit être un entier positif." >&2S
		exit 2
	fi

	nbLines=$(fileLines $2)
	if [ $1 -gt $nbLines ] || [ $1 -eq "0" ]
	then
		echo "La line $1 n'existe pas dans le fichier $2." >&2
		exit 1
	fi
	
	head -n$1 $2 | tail -n1
}


trierScores()
{
	if [[ $SER_SCORE == "" ]]
	then	
		echo "Veuillez exporter \$SER_SCORE avec la valeur '../data/score.data" >&2
		exit 1;
	fi
	cat $SER_SCORE > ficTempo
	cat ficTempo | sort -t: -k2n > $SER_SCORE
	rm ficTempo
}

# $1 = pseudo
# $2 = score
# $3 = jeu
ajouterScore()
{
	if [ $# -lt 3 ]
	then
		echo "Cette fonction doit être appelée de la manière suivante :" >&2
		echo "ajouterScore <pseudo> <score> <jeu>" >&2
		exit
	fi
	echo "$1:$2:$3" >> $SER_SCORE
}

afficherMeilleursJoueurs()
{
	echo "10 meilleurs joueurs :"
	head $SER_SCORE
}

#efface toutes les lignes du fichier $SER_SCORE
effacerScores()
{
	echo "" > $SER_SCORE
}

#Supprime toutes les lignes du fichier $SER_SCORE contenant $1
effacerScoresJeu()
{
	if [ $# -lt 1 ]
	then
		echo "Cette fonction doit être appelée de la manière suivante :" >&2
		echo "effacerScoresJeu <jeu>" >&2
		exit
	fi
	cat $SER_SCORE > ficTempo
	sed '/'$1'/d' ficTempo > $SER_SCORE
	rm ficTempo
}


afficherMetaDonnees()
{
	if [ $# -lt 1 ]
	then
		echo "Cette fonction doit être appelée de la manière suivante :" >&2
		echo "afficherMetaDonnees <jeu>" >&2
		exit
	fi
	cat ../data/ser_data | grep $1
}



