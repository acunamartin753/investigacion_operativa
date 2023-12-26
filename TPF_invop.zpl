param n := 10;
param m := 18;
param c:=5; 
param d:=13;

set I := {1..10};
set Is := {1,2};
set K := {1..18};
set Kodd := {1,3,5,7,9,11,13,15,17};

var X[I*I*K] binary;
var W[I*Kodd] binary;
var Y[I*Kodd] binary;

minimize z: sum <i,k> in I*Kodd : W[i,k];

subto r1: forall <i,j> in I*I with i != j do sum <k> in K with k<=(n-1) : (X[i,j,k] + X[j,i,k]) == 1;
subto r2: forall <i,j> in I*I with i != j do sum <k> in K with k > (n-1) : (X[i,j,k] + X[j,i,k]) == 1;
subto r3: forall <i,j> in I*I with i != j do sum <k> in K : (X[i,j,k]) == 1 ;
subto r4: forall <j,k> in I*K do sum <i> in I with i != j : (X[i,j,k] + X[j,i,k]) == 1;
subto r5: forall <i,k> in (I without Is)*{1..m-1} do (sum <j> in Is : (X[i,j,k] + X[j,i,k] + X[i,j,k+1] + X[j,i,k+1])) <= 1;
subto r6_a: forall <i> in I do sum <k> in Kodd : Y[i,k] >= n/2-1;
subto r6_b: forall <i> in I do sum <k> in Kodd : Y[i,k] <= n/2;
subto r7: forall <i,k> in I*Kodd do (sum <j> in I with i != j : (X[i,j,k] + X[i,j,k+1])) <= 1+Y[i,k]; 
subto r8: forall <i,k> in I*Kodd do Y[i,k] <= (sum <j> in I with i != j : X[i,j,k]); 
subto r9: forall <i,k> in I*Kodd do Y[i,k] <= (sum <j> in I with i != j : X[j,i,k+1]);
subto r10: forall <i,k> in I*Kodd do (sum <j> in I with i != j : (X[j,i,k] + X[j,i,k+1])) <= 1+W[i,k]; 
subto r11: forall <i,k> in I*Kodd do W[i,k] <= (sum <j> in I with i != j : X[j,i,k]); 
subto r12: forall <i,k> in I*Kodd do W[i,k] <= (sum <j> in I with i != j : X[j,i,k+1]);

# Simetrias
#subto espejada : forall <i,j,k> in I*I*K with i != j and k < (n-1) do X[i,j,k]==X[j,i,k+n-1];

#subto Francesa_a : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= (n-1) do X[i,j,1]==X[j,i,2*n-2];

#subto Francesa_b : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= n-1 do X[i,j,k]==X[j,i,k+n-2];

#subto Inglesa_1 : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= n-2 do X[i,j,n-1]==X[j,i,n];

#subto Inglesa_2 : forall <i,j,k> in I*I*K with i != j and 2 <= k and k <= n-2 do X[i,j,k]==X[j,i,k+n];

#subto invertida : forall <i,j,k> in I*I*K with i != j and 1 <= k and k <= n-1 do X[i,j,k]==X[j,i,2*n-1-k];

#subto BTB : forall <i,j,k> in I*I*Kodd with i != j do X[i,j,k]==X[j,i,k+1];

subto min_max_a: forall <i,j,k> in I*I*{1..18-c} with i!=j do (sum <k2> in K with k<=k2 and k2<= k+c and i !=j : (X[i,j,k2]+ X[j,i,k2])) <= 1;

subto min_max_b: forall <i,j,k> in I*I*K with i!=j do (sum <k2> in K with k-d <= k2 and k2 <= k+d and k!= k2 : X[i,j,k2]) >= X[j,i,k];





