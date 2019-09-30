#! /bin/bash
# Ce script doit être appelé de la manière suivante :
# ./quizz.sh <cheminFichier> <numColQ> <numColR>
# <cheminFichier> représente le nom du fichier
# <numColQ> représente le numéro d'une méta-donnée associée à la question (pays,capitale,monnaie)
# <numColR> représente le numéro d'une méta-donnée associée à la réponse (pays,capitale,monnaie)
source ../libsh/lib.sh

if [ $# -lt 3 ]
then
	echo "Il faut 4 arguments pour ce script. " >&2
	echo "./quizz.sh <cheminFichier> <numColQ> <numColR>" >&2
	exit 1
fi

if [ ! -e $1 ]
then
	echo "Le fichier $1 n'existe pas." >&2
	exit 2
fi

if [[ $2 != +([0-9]) ]] || [[ $3 != +([0-9]) ]] || [[ $2 == $3 ]]
then
	echo "<numColQ> et <numColR> doivent être des entiers positifs distincts." >&2
	exit 3
fi

premiereLigne=$(grepLine 1 $1)

#verification sur validité de <numColQ>
nbColonnes=$( echo $premiereLigne | sed "s/:/ /g" | wc -w) # wc -w compte le nombre de mots
if [ $2 -gt $nbColonnes -o $2 -eq "0" ]
then
	echo "La colonne $2 n'existe pas." >&2
	exit 4
fi

#verification sur validité de <numColR>
if [ $3 -gt $nbColonnes -o $3 -eq "0" ]
then
	echo "La colonne $3 n'existe pas." >&2
	exit 4
fi

metaQuestion=$(echo $premiereLigne | cut -d: -f$2)
metaReponse=$(echo $premiereLigne | cut -d: -f$3)

maxLignes=$(fileLines $1)
ligneQuizz=$(rand 2 $maxLignes)

ligneDonnees=$(grepLine $ligneQuizz $1)
donneeQuestion=$(echo $ligneDonnees | cut -d: -f$2)
donneeReponse=$(echo $ligneDonnees | cut -d: -f$3)

echo "$metaQuestion : $donneeQuestion"
echo "$metaReponse : ?"

read reponseUtilisateur
if [[ ${reponseUtilisateur,,} == ${donneeReponse,,} ]] # Cette comparaison ignore la casse
then
	echo "Bonne réponse !"
else
	echo "Faux ! La bonne réponse était : '$donneeReponse' ( vous avez écrit '$reponseUtilisateur' )"
fi

score=$(rand 1 20)
nomJeu="quizz"
ajouterScore $PSEUDO $score $nomJeu


