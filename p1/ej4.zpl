set I := {1..3};
set J := {1..3};
set K := {"CMP", "VMC", "PCE"};
param M := 9999999;

param c[I*J] := | 1, 2, 3|
	| 1 | 2, 4, 3|
	| 2 | 5, 3, 6|
	| 3 | 3, 4, 2|;

param m[K*J] := | 1, 2, 3|
	| "CMP" | 200, 400, 200|
	| "VMC" | 150, 250, 200|
	| "PCE" | 200, 150, 100|;

param contaminacion[I] := <1> 0.5, <2> 2, <3> 1;

var X[J] binary; 	# La fabrica se construye o no en la ubicacion j;
var W[I] integer; 	# Unidades producidas del producto i;
var E[J] binary; 	# La fabrica excede el vmc en la ubicacion j

maximize beneficio: sum <i,j> in I cross J : (X[j] * W[i] * c[i,j] - E[j] * m["PCE",j] * (W[i] * contaminacion[i] - m["VMC",j]));

subto r1 : sum <j> in J : X[j] == 1;
subto r2 : forall <i,j> in I cross J do W[i] * X[j] <= m["CMP", j];
subto r3 : forall <i,j> in I cross J do E[j] * m["PCE",j] * (W[i] * contaminacion[i] - m["VMC",j]) <= 90000;
subto r4 : forall <j> in J do E[j] <= X[j];
subto r5 : forall <i,j> in I cross J do E[j] * M >=  (W[i] * contaminacion[i] - m["VMC",j]);
subto r6 : forall <i,j> in I cross J do (1-E[j]) * (-M) <=  (W[i] * contaminacion[i] - m["VMC",j]);
