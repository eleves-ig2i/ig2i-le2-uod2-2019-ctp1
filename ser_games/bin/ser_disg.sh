#! /bin/bash

#Ce script doit être appelé de la manière suivante :
# ./ser_eng.sh <cheminFichier>
# Il vérifie la présence de cheminFichier dans le répertoire games_available
# Si c'est le cas alors il crée un lien symbolique vers ce fichier dans le répertoire games_enabled

if [ $# -lt 1 ]
then
	echo "Il faut 1 argument pour ce script. " >&2
	echo "./ser_eng.sh <cheminFichier>" >&2
	exit 1
fi

if [ ! -e $1 ]
then
	echo "Le fichier $1 n'existe pas." >&2
	exit 2
fi


pattern='../games_available/(.*)';
if [[ ! $1 =~ $pattern ]]
then
	echo "Le fichier $1 ne se situe pas dans le répertoire ../games_available" >&2
	exit 3
fi

nomExecutable=$(echo $1 | cut -d\/ -f3);
cheminRepertoireLien="../games_enabled/";
echo "Executable $nomExecutable choisi";
unlink $cheminRepertoireLien$nomExecutable
