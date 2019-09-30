#! /bin/bash

#Ce script doit être appelé de la manière suivante :
# ./ser_games.sh

source ../libsh/lib.sh
echo "Pseudo :"
read PSEUDO
export PSEUDO #nécessaire pour utiliser la variable dans les jeux


#La case i de tabInodes correspond à l'inode pointant vers l'exécutable dont le nom est contenu dans la case i de tabJeux
tabInodes=() 
tabJeux=()

echo "Jeux autorisés :"
cheminJeuxActifs="../games_enabled/"
data=$(ls -i $cheminJeuxActifs)
nbChamps=$(echo $data | awk -F\  '{printf NF}') # on a nbJeux*2 champs
nbJeux=$(expr $nbChamps \/ 2)
indice=1
for i in `seq 1 2 $nbChamps`
do
	tabInodes[indice]=$(echo $data | tr '\n' ' ' | cut -d\  -f$i)
	j=$(expr $i + 1)
	tabJeux[indice]=$(echo $data | tr '\n' ' ' | cut -d\  -f$j)
	indice=$(expr $indice + 1)
done


reponse="y"
while [[ $reponse != "n" ]]
do
	#Affichage menu
	echo "0 - Afficher les scores des 10 meilleurs joueurs."
	echo "1 - Effacer tous les scores."
	echo "2 - Effacer les scores d'un jeu."
	echo "a - Afficher les métas données d'un jeu"
	for i in `seq 1 $nbJeux`
	do
		echo "${tabInodes[i]} - ${tabJeux[i]}"
	done
	echo "---------------------------------------"
	echo "Choisissez votre jeu à partir du numéro"
	read reponseInode

	for i in `seq 1 $nbJeux`
	do
		if [[ $reponseInode == ${tabInodes[i]} ]]
		then
			echo "Jeu ${tabJeux[i]} sélectionné"
			cheminJeu=$cheminJeuxActifs${tabJeux[i]}
			./$cheminJeu $PSEUDO
			trierScores
			break
		fi
	done
	case $reponseInode in
		0)
			echo "Affichage des 10 meilleurs joueurs"
			afficherMeilleursJoueurs
			;;
	
		1)
			effacerScores 
			;;

		2)
			echo "Donnez le nom du jeu (sans '.sh') à réinitialiser"
			read nomJeu
			effacerScoresJeu $nomJeu
			;;
		a)
			echo "Donnez le nom du jeu (sans '.sh') dont les métadonnées sont à visualiser."
			read nomJeu
			afficherMetaDonnees $nomJeu
			;;
	esac

	echo "Voulez-vous jouer à un autre jeu ? (y/n)"
	read reponse
	
done

exit 0


