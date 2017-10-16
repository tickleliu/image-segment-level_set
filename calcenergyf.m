%��ʾ��������ͼ������Ϊ��ˮƽ������ifro��������ԭͼ����������Ϊrgbͼ����������ɫ��ʾ
%��������������
function [ inside, outside ] = calcenergyf( u0, phi, epsilon )
H_phi = heavisidef( phi, epsilon );
H_phi_minus = 1 - heavisidef( phi, epsilon );


c1 = sum( sum( u0 .* H_phi ) ) /  sum( sum( H_phi ) );
c2 = sum( sum( u0 .* H_phi_minus ) ) / sum( sum( H_phi_minus ) );


inside = ( u0 - c1 ).^2;
outside = ( u0 - c2 ).^2;