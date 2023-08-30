set I := {1..6};
set J := {"UtNeta", "Financiamiento"};

var P[I];	# Presupuesto asignado al proyecto i en millones de pesos

param c[I*J] := |"UtNeta", "Financiamiento"|
|1| 4.4, 220|
|2| 3.8, 180|
|3| 4.1, 250|
|4| 3.5, 150|
|5| 5.1, 400|
|6| 3.2, 120|;

param clase[I] := <1> "Solar", <2> "Solar", <3> "CombSinteticos", <4> "Carbon", <5> "Nuclear", <6> "Geotermico";

maximize beneficios: sum <i> in I: P[i] * c[i, "UtNeta"]; # En millones de pesos

subto r1 : sum <i> in I: P[i] <= 1000;
subto r2 : forall <i> in I with clase[i]=="Nuclear" : P[i] >= c[i, "Financiamiento"] / 2;
subto r3 : sum <i> in I with clase[i]=="Solar": P[i] >= 300;
subto r4 : forall <i> in I do: P[i] <= c[i,"Financiamiento"] 
