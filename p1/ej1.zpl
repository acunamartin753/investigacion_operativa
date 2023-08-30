set I := {"A1", "A2", "A3"};
set J := {"vitA", "vitC", "vitD"};
var x[I];	# cantidad de alimento i que se compra

param c[I*J] := | "vitA", "vitC", "vitD"|
|"A1"| 0.03, 0.01, 0.04|
|"A2"| 0.02, 0.015, 0.03|
|"A3"| 0.04, 0.005, 0.02|;

param precio[I] := <"A1"> 0.15, <"A2"> 0.10, <"A3"> 0.12;
param rdm[J] := <"vitA" > 0.3, <"vitC" > 0.12, <"vitD" > 0.21;

minimize costo: sum <i> in I: precio[i]/30 * x[i];

subto r1: sum <i> in I: x[i] >= 225;
subto r2: forall <j> in J:
sum <i> in I: (c[i,j]*x[i]/30) >= rdm[j];