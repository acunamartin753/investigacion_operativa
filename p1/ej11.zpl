set I := {1..8};
set J := {1..8};
set K := {1..9};

var X[I*J] binary;    #Se coloca un alfil en la casilla (i,j)

maximize alfiles: sum <i,j> in I*J: X[i,j];

subto r1: forall <i> in I do sum <j> in {1..9-i} : X[i+j-1,j] <= 2; 
subto r2: forall <j> in J do sum <i> in {1..9-j} : X[i,j+i-1] <= 2;
subto r3: forall <i> in I do sum <j> in {1..i} : X[i-j+1,j] <= 2;
subto r4: forall <j> in J do sum <i> in {j..8} : X[i,8-i+j] <= 2;
