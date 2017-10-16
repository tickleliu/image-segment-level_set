function newim = createim( im, phi )
newim( :, :, 1 ) = im;
newim( :, :, 3 ) = im;


tempim = im;
tempim( find( isfro( phi ) ) ) = 0;


newim( :, :, 2 ) = tempim;


newim = uint8( newim );