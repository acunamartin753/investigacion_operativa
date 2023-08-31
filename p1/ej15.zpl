set I := {"x", "y", "w"};

var V[I] real;			# Las variables
var M[I] real >= 0;		# Los modulos de x, y, w

minimize z: sum <i> in I : M[i];

subto r1: V["x"] + V["y"] <= 1;
subto r2: 2 * V["x"] + V["w"] == 3;
subto r4: forall <i> in I do M[i] >= V[i];
subto r5: forall <i> in I do M[i] <= V[i];