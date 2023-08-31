set I := {"A", "B", "C"};
set J := {1..3};
set K := {1..5};
param M := 9999999;

param c[I*J] := | 1, 2, 3|
		| "A" | 9, 6, 5 |
		| "B" | 7, 4, 9 |
		| "C" | 4, 6, 3 |;

param sobra[I] := <"A"> 700, <"B"> 600, <"C"> 400;
param falta[J] := <1> 800, <2> 500, <3> 400;

var T[I*J*K]; 		# Cantidad de kilos llevados desde i hasta j con el camion k
var X[I*J*K] binary; 	# Uso el camion k para ir desde i hasta j
var W[K] binary; 	# Uso el camion k

minimize costo: (sum <k> in {1..4}: W[k] * 50) + (W[5] * 65) + (sum <i,j,k> in I*J*K: T[i,j,k] * c[i,j]);

subto r1: forall <i> in I do sum <j,k> in J*K: T[i,j,k] == sobra[i];
subto r2: forall <j> in J do sum <i,k> in I*K: T[i,j,k] == falta[j];
subto r3: forall <i,j,k> in I*J*K do T[i,j,k] >= 0;
subto r4: forall <i,j,k> in I*J*K do T[i,j,k] <= 600;
subto r5: forall <k> in K do sum <i,j> in I*J: X[i,j,k] <= 1;
subto r6: forall <k> in K do X["A",2,k] + X["B",2,k] <= 1;
subto r7: forall <i,j,k> in I*J*K do X[i,j,k] <= T[i,j,k];
subto r8: forall <i,j,k> in I*J*K do X[i,j,k]*M >= T[i,j,k];
subto r9: forall <k> in K do sum <i,j> in I*J: X[i,j,k] == W[k];	
