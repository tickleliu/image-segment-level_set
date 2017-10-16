%显示代轮廓的图像，轮廓为零水平集，用ifro检测出。将原图和轮廓叠加为rgb图像，轮廓用绿色表示
%求轮廓内外能量
function [ inside, outside ] = calcenergyf( u0, phi, epsilon )
H_phi = heavisidef( phi, epsilon );
H_phi_minus = 1 - heavisidef( phi, epsilon );


c1 = sum( sum( u0 .* H_phi ) ) /  sum( sum( H_phi ) );
c2 = sum( sum( u0 .* H_phi_minus ) ) / sum( sum( H_phi_minus ) );


inside = ( u0 - c1 ).^2;
outside = ( u0 - c2 ).^2;