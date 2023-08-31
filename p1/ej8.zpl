set I := {1..4};
set J := {2..5};
set K := {1..4};
set L := {2..5};

param U[I*J] := | 2, 3, 4, 5|
			| 1 | 12, 22, 38, 40|
			| 2 | -1, 13, 20, 29|
			| 3 | -1, -1, 10, 19|
			| 4 | -1, -1, -1, 12|;

var X[<i,j> in I*J with i < j] binary;		# Se alquila desde el inicio del año y hasta el inicio del año j

maximize ganancia: sum <i,j> in I*J with i < j: X[i,j]*U[i,j];

subto r1: sum <i,j> in I*J with i < j : X[i,j] * (j-i) <= 4;
subto r2: forall <i,j> in I*J with i < j do sum <k,l> in K*L with k<=i and l>i: X[k,l] <= 1;
