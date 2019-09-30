#! /bin/bash

afficherMenu()
{
	echo "a - Créer un nouveau jeu." # ajouter une ligne dans le fichier ser_data contenant le nom du jeu.
	echo "b - Ajouter une méta-donnée." # ajouter un champ en fin de ligne d'un jeu donnée.	
	echo "c - Modifier une méta-donnée."	# modifier un champ parmi ceux déjà existants pour le jeu.
	echo "d - Supprimer une méta-donnée."	# supprimer un champ parmi ceux déjà existants pour le jeu.
}
