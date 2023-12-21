param n := 10;
param c := 6;
param d := 12;

set I := {1..n}; #paises
set K := {1..18};  #partidos
set Kodd := {1,3,5,7,9,11,13,15,17}; #partidos impares
set H := {1..2}; #paises importantes (arg es 1 y bra es 2), en una corrida va y en otra sacarlo


var X[I*I*K] binary; #vale 1 si el team i juega en casa vs team j en la ronda k
var Y[I*Kodd] binary; #which take a value of 1 if team i has an H-A sequence in the double round that start at round k and zero otherwise
var W[I*Kodd] binary; #which take a value of 1if team i has an away break in the double round starting in round kand zero otherwise.


# Restricciones
subto r1 : forall <i,j> in I*I with i != j do sum <k> in K with k <= n-1: (X[i,j,k]+X[j,i,k]) == 1;
subto r2 : forall <i,j> in I*I with i != j do sum <k> in K with k > n-1: (X[i,j,k]+X[j,i,k]) == 1;
subto r3 : forall <i,j> in I*I with i != j do sum <k> in K : X[i,j,k] == 1;
subto r4 : forall <j,k> in I*K do sum <i> in I with i != j: (X[i,j,k]+X[j,i,k]) == 1;
subto r5 : forall <i,k> in {3..10}*K with k<18 do sum <j> in H : (X[i,j,k]+X[j,i,k]+X[i,j,k+1]+X[j,i,k+1]) <= 1; 
subto r6 : forall <i> in I do sum <k> in Kodd : Y[i,k] <= n/2;
subto r6bis : forall <i> in I do sum <k> in Kodd : Y[i,k] >= n/2 - 1;
subto r7 : forall <i,k> in I*Kodd do sum <j> in I with j != i : (X[i,j,k]+X[j,i,k+1]) <= 1+Y[i,k];
subto r8 : forall <i,k> in I*Kodd do sum <j> in I with j != i : X[i,j,k] >= Y[i,k];
subto r9 : forall <i,k> in I*Kodd do sum <j> in I with j != i : X[j,i,k+1] >= Y[i,k];
subto r10 : forall <i,k> in I*Kodd do sum <j> in I with j != i : (X[j,i,k]+X[j,i,k+1]) <= 1+W[i,k];
subto r11 : forall <i,k> in I*Kodd do sum <j> in I with j != i : X[j,i,k] >= W[i,k];
subto r12 : forall <i,k> in I*Kodd do sum <j> in I with j != i : X[j,i,k+1] >= W[i,k];

# Simetrias
subto espejada : forall <i,j,k> in I*I*K with i != j and k < (n-1) do X[i,j,k]==X[j,i,k+n-1];

subto Francesa_1 : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= (n-1) do X[i,j,1]==X[j,i,2*n-2];

subto Francesa_2 : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= n-1 do X[i,j,k]==X[j,i,k+n-2];

subto Inglesa_1 : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= n-2 do X[i,j,n-1]==X[j,i,n];

subto Inglesa_2 : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= n-2 do X[i,j,k]==X[j,i,k+n];

subto invertida : forall <i,j,k> in I*I*K with i != j and 1 <= k and k <= n-1 do X[i,j,k]==X[j,i,2*n-1-k];

subto BTB : forall <i,j,k> in I*I*Kodd with i != j do X[i,j,k]==X[j,i,k+1];

subto min_max_a : forall <i,j,k> in I*I*K with i != j and k <= 18-c do sum <k2> in K with k <= k2 and k2 <= k+c : (X[i,j,k2]+X[j,i,k2]) <= 1;

subto min_max_b : forall <i,j,k> in I*I*K with i != j do sum <k2> in K with (k-d) <= k2 and 1 <= k2 and (k2 <= (k+d) or k2 <= (2*(n-1))) and k2 != k : X[i,j,k2] >= X[j,i,k];

# Funcion objetivo
minimize z: sum <i,k> in I*Kodd :W[i,k];






