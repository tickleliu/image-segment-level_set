%用于求轮廓内外能量
function value = heavisidef( z, epsilon )
value = 0.5 .* ( 1 + ( 2 ./ pi ) .* atan( z ./ epsilon ) );

