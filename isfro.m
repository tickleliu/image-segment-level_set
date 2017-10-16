%检测零水平集的位置
function front = isfro( phi )
[ n, m ] = size( phi );
front = zeros( size( phi ) );
for i = 2 : n - 1;
  for j = 2 : m - 1;


    maxVal = max( max( phi( i:i+1, j:j+1 ) ) );
    minVal = min( min( phi( i:i+1, j:j+1 ) ) );
    front( i, j ) = ( ( maxVal > 0 ) & ( minVal < 0 ) ) | phi( i, j ) == 0;


  end
end