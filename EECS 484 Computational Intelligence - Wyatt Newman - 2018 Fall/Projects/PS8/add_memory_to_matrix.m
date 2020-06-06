function [ MatrixMem ] = add_memory_to_matrix( file_name, MatrixMem )
%ADD_MEMORY_TO_MATRIX adds a specified memory (via file name)
% to the provided matrix

% read in image
A = imread(['bitmaps/' file_name]);
[nrows,ncols]=size(A); %get bitmap dimensions;
nbits=nrows*ncols; %when string out matrix, will have this many bits in vector

% convert matrix of image to bipolar vector
Avec = matrix2vec(A);

% create our matrix memory
M=Avec*Avec';

% suppress diagonal of memory
M = M - eye([nbits nbits]);

% add memory to bank of memories
MatrixMem=MatrixMem+M;

end

