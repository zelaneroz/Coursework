%content_addressable_memory.m: 
% read in files to memorize and cues to recover memories
nrows = 16;
ncols = 32;
nbits = nrows * ncols;

% initialize 512x512 matrix for storing memories
MatrixMem = zeros(nbits,nbits);

% read in all images possible for perfect convergence 
% read them in alphabetical order to make organization easy
MatrixMem = add_memory_to_matrix('clubspade.bmp', MatrixMem);
%MatrixMem = add_memory_to_matrix('computersum.bmp', MatrixMem);
MatrixMem = add_memory_to_matrix('handheart.bmp', MatrixMem);
MatrixMem = add_memory_to_matrix('happyworld.bmp', MatrixMem);
%MatrixMem = add_memory_to_matrix('notespell.bmp', MatrixMem);
MatrixMem = add_memory_to_matrix('printtrash.bmp', MatrixMem);
MatrixMem = add_memory_to_matrix('winhelp.bmp', MatrixMem);

% the error file cell array
x = {};

% read in erroroneous bitmap as matrix
err_clubspade = 'bitmaps/err_clubspade.bmp';
x = [x err_clubspade];
err_compsum = 'bitmaps/err_computersum.bmp';
x = [x err_compsum];
err_handheart = 'bitmaps/err_handheart.bmp';
x = [x err_handheart];
err_happyworld = 'bitmaps/err_happyworld.bmp';
x = [x err_happyworld];
err_notespell = 'bitmaps/err_notespell.bmp';
x = [x err_notespell];
err_printtrash = 'bitmaps/err_printtrash.bmp';
x = [x err_printtrash];
err_winhelp = 'bitmaps/err_winhelp.bmp';
x = [x err_winhelp];

% eliminate manual labor of changing file names, etc.
for i=1:length(x)
    fname=x{i};

    % read erroneous bitmap
    Aerr=imread(fname);
    
    % convert erroneous bitmap matrix to vector
    Avec_err=matrix2vec(Aerr);
    AVecRecall=Avec_err;
    
    % provide only a file name to output function
    fname = strrep(fname, 'bitmaps/', '');

    % stores output image in "/output" directory
    error_correction_strategy(fname, AVecRecall, MatrixMem, nrows, ncols);
end

