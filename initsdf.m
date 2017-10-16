%子函数
%初始化水平集函数，符号距离函数
function phi = initsdf( imsize, center, radius, isinside )
m = imsize( 1 ); n = imsize( 2 );
phi = zeros( imsize );
for i = 1 : m;
  for j = 1 : n;
     distance = sqrt( sum( ( center - [ i, j ] ).^2 ) );
     phi( i, j ) = distance - radius;
    if( isinside == 0 )
      phi( i, j ) = -phi( i, j );
    end
  end
end