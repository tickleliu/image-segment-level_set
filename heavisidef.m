%������������������
function value = heavisidef( z, epsilon )
value = 0.5 .* ( 1 + ( 2 ./ pi ) .* atan( z ./ epsilon ) );

