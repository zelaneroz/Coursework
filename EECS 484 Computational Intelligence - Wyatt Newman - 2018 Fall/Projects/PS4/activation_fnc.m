%Activation function--linear for u>=0, zero for u<0
function sigma = activation_fnc(u)

 % a positive activation function
 % assign sigma to input unless < 0, then assign sigma to 0
 if u >= 0
     % a pure linear activation function (output = input)
     sigma = u;
 else
     sigma = 0;
 end
