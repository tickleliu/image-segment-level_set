function phiy = activecontourCV( u0, center, radius, isinside, d_it, m_it, m_name )
% 用主动轮廓线CV算法对输入图像u0实现图像边缘提取
% 输入图像为double型，灰度为1—256的图像。选用圆形起始轮廓线
% center为起始轮廓线原点，radius为起始轮廓线半径。isinside 表示边缘目标在起始轮廓线外还是内，=1表示目标在起始轮廓线内，=0表示在外
% 初始化参数
ITERATIONS = 5000;%迭代次数
delta_t = 5;%时间步长
%轮廓内外能量参数
lambda1 = 1;
lambda2 = 1;
nu = 0;
%曲率项参数
h = 1; h_sq = h^2;
epsilon = 1;
mu = 0.01 * 255^2;

%laplace卷积核
kernal = [0.5 1 0.5; 1 -6 1; 0.5 1 0.5];

% 初始化符号距离函数
phi = initsdf( size( u0 ), center, radius, isinside );


for ii = 1 : ITERATIONS;


  % 显示当前迭代次数
  fprintf( 1, '%d\n', ii );


  % 每d_it显示一次图像
  if( mod( ii - 1, d_it ) == 0 )
    disp( 'Displaying Segmented Image' );
    segim = createim( u0, phi );
    clf; imshow( segim );
    drawnow;
  end;
%   
%   % 每m_it次保存一次图像
%    if( mod( ii - 1, m_it ) == 0 )
%     segim = createim( u0, phi );
%     filename = strcat( m_name, sprintf( '%06d', ( ( ii - 1 )/ m_it ) + 1 ), '.png' );
%     imwrite( segim, filename );
%   end;


  %delta_t*狄力克函数
  dirac_delta_t = delta_t * diracfunction( phi, epsilon );


  % 计算轮廓线内外能量
  [ inside, outside ] = calcenergyf( u0, phi, epsilon );
  energy_term = -nu - lambda1 .* inside + lambda2 .* outside;%能量项


  % 中心差分
  dx_central = ( circshift( phi, [ 0, -1 ] ) - circshift( phi, [ 0, 1 ] ) ) / 2;
  dy_central = ( circshift( phi, [ -1, 0 ] ) - circshift( phi, [ 1, 0 ] ) ) / 2;


  % div(delt_phi/|delta_phi|)
  abs_grad_phi = ( sqrt( dx_central.^2 + dy_central.^2 ) + 0.00001 );
  x = dx_central ./ abs_grad_phi;
  y = dy_central ./ abs_grad_phi;
  grad_term = ( mu / h_sq ) .* divergence( x, y );%梯度能量

  %phi
  pent_term =  1.5 * (filter2(kernal, phi) - divergence( x, y ));
  
  
  % phi(n+1)
  phi = phi + dirac_delta_t .* ( grad_term + energy_term +  pent_term);
%   phi = phi + dirac_delta_t .* ( grad_term + energy_term);
%   phiy(:,:,ii)=phi;%保存每次迭代结果
end;


















