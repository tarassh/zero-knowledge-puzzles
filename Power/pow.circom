pragma circom 2.1.4;

// Create a circuit which takes an input 'a',(array of length 2 ) , then  implement power modulo 
// and return it using output 'c'.

// HINT: Non Quadratic constraints are not allowed. 

include "../node_modules/circomlib/circuits/comparators.circom";

template Pow(BITS) {
   signal input a[2];
   signal output c;

   signal powers[BITS];
   signal enable[BITS];
   signal result[BITS];

   powers[0] <== 1;
   enable[0] <== 1;
   result[0] <== IsZero()(a[1]);
   
   for (var i = 1; i < BITS; i++) {
      powers[i] <== powers[i-1] * a[0];
      enable[i] <== IsEqual()([i, a[1]]);
      result[i] <== result[i-1] + powers[i] * enable[i];
   }

   c <== result[BITS-1];
}

component main = Pow(8);