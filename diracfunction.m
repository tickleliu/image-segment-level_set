%�����˺��������ڼ���Ŀ��Ŀ��Ĳ���
function y = diracfunction( x, epsilon )
y = ( 1 ./ pi ) .* ( epsilon ./ ( epsilon.^2 + x.^2 ) );