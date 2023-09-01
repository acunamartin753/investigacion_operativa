set I := {1..4};
set J := {1..5};
set S := {1..3};
set H := {1..6};
set K := {"Regalias", "LCME", "ICM"};

param extremos_a[H] := <1> 0, <2> 2, <3> 2, <4> 4, <5> 4, <6> 5;
param extremos_f_a[H] := <1> 0, <2> 4, <3> 7, <4> 13, <5> 27, <6> 32;
param epsilon := 0.0000001;
param demanda[J] := <1> 0.9, <2> 0.8, <3> 1.2, <4> 1, <5> 1.1;
param c[K*I] := | 1, 2, 3, 4 |
	| "Regalias" | 5, 7, 4, 6 |
	| "LCME" | 2, 2.5, 1.7, 3 |
	| "ICM" | 1, 0.7, 1.5, 0.5|;

var X[I*J] real >=0;	# Cantidad de toneladas extraidas de la mina i el año j
var W[I*J] binary;		# Se trabaja en la mina i el año j
var V[I*J] binary;  	# La mina i esta abierta el año j
var A[J] real >= 0; 	# El indicador ambiental del año j
var D[S*J] binary;  	# A[j] cae en el s-esimo caso
var G[H*J] real >= 0;	# Coeficientes de la combinacion lineal convexa entre los extremos del interalo correspondiente al año j
var F[J]; 				# Multa a pagar por la contaminacion el año j

maximize z: 10 * (sum <i,j> in I*J: X[i,j]) - (sum <j> in J: F[j]) - (sum <i,j> in I*J : c["Regalias", i] * V[i,j]);

subto r1 : forall <j> in J do sum <i> in I : W[i,j] <= 3;
subto r2 : forall <i,j> in I*J do W[i,j] <= V[i,j];
subto r3 : forall <i,j> in I*{1..4} do V[i,j+1] <= V[i,j];
subto r4 : forall <i,j> in I*J do X[i,j] <= c["LCME", i] * W[i,j];
subto r5 : forall <j> in J do demanda[j] * sum <i> in I: X[i,j] == sum <i> in I: c["ICM", i] * X[i,j];
subto r6 : forall <j> in J do A[j] >= (sum <i> in I: X[i,j]) * 2/3;
subto r7 : forall <j> in J do 0 <= A[j] <= 5;
subto r8 : forall <j> in J do sum <s> in S: D[s,j] == 1;
subto r9 : forall <j,s> in J*S do G[2*s-1,j] + G[2*s,j] == D[s,j];
subto r10 : forall <i,j> in {3,5}*J do G[i,j] <= 1-epsilon;
subto r11 : forall <j> in J do A[j] == sum <h> in H: extremos_a[h] * G[h,j];
subto r12 : forall <j> in J do F[j] == sum <h> in H: extremos_f_a[h] * G[h,j];
