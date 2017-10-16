function phiy = activecontourCV( u0, center, radius, isinside, d_it, m_it, m_name )
% ������������CV�㷨������ͼ��u0ʵ��ͼ���Ե��ȡ
% ����ͼ��Ϊdouble�ͣ��Ҷ�Ϊ1��256��ͼ��ѡ��Բ����ʼ������
% centerΪ��ʼ������ԭ�㣬radiusΪ��ʼ�����߰뾶��isinside ��ʾ��ԵĿ������ʼ�������⻹���ڣ�=1��ʾĿ������ʼ�������ڣ�=0��ʾ����
% ��ʼ������
ITERATIONS = 5000;%��������
delta_t = 5;%ʱ�䲽��
%����������������
lambda1 = 1;
lambda2 = 1;
nu = 0;
%���������
h = 1; h_sq = h^2;
epsilon = 1;
mu = 0.01 * 255^2;

%laplace�����
kernal = [0.5 1 0.5; 1 -6 1; 0.5 1 0.5];

% ��ʼ�����ž��뺯��
phi = initsdf( size( u0 ), center, radius, isinside );


for ii = 1 : ITERATIONS;


  % ��ʾ��ǰ��������
  fprintf( 1, '%d\n', ii );


  % ÿd_it��ʾһ��ͼ��
  if( mod( ii - 1, d_it ) == 0 )
    disp( 'Displaying Segmented Image' );
    segim = createim( u0, phi );
    clf; imshow( segim );
    drawnow;
  end;
%   
%   % ÿm_it�α���һ��ͼ��
%    if( mod( ii - 1, m_it ) == 0 )
%     segim = createim( u0, phi );
%     filename = strcat( m_name, sprintf( '%06d', ( ( ii - 1 )/ m_it ) + 1 ), '.png' );
%     imwrite( segim, filename );
%   end;


  %delta_t*�����˺���
  dirac_delta_t = delta_t * diracfunction( phi, epsilon );


  % ������������������
  [ inside, outside ] = calcenergyf( u0, phi, epsilon );
  energy_term = -nu - lambda1 .* inside + lambda2 .* outside;%������


  % ���Ĳ��
  dx_central = ( circshift( phi, [ 0, -1 ] ) - circshift( phi, [ 0, 1 ] ) ) / 2;
  dy_central = ( circshift( phi, [ -1, 0 ] ) - circshift( phi, [ 1, 0 ] ) ) / 2;


  % div(delt_phi/|delta_phi|)
  abs_grad_phi = ( sqrt( dx_central.^2 + dy_central.^2 ) + 0.00001 );
  x = dx_central ./ abs_grad_phi;
  y = dy_central ./ abs_grad_phi;
  grad_term = ( mu / h_sq ) .* divergence( x, y );%�ݶ�����

  %phi
  pent_term =  1.5 * (filter2(kernal, phi) - divergence( x, y ));
  
  
  % phi(n+1)
  phi = phi + dirac_delta_t .* ( grad_term + energy_term +  pent_term);
%   phi = phi + dirac_delta_t .* ( grad_term + energy_term);
%   phiy(:,:,ii)=phi;%����ÿ�ε������
end;


















