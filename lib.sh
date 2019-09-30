nieme() {

    	q=`head -n $1 $2 | tail -n 1` # equiv => sed -n "$1 p" $2
    	echo $q
}


nbLigne() {

	nb=`cat $1 | wc -l`
	echo $nb
}

rand() {

	largeur=`expr $2 - $1 + 1`
	r=`expr $RANDOM % $largeur`
	r=`expr $r + $1` # equiv r=$($r + 1) <=> ((r=$r + 1))
	echo $r
}
