%狄力克函数，利于检测出目标的空心部分
function y = diracfunction( x, epsilon )
y = ( 1 ./ pi ) .* ( epsilon ./ ( epsilon.^2 + x.^2 ) );