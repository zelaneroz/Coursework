function error_correction_strategy( cue_name, AVecRecall, MatrixMem, nrows, ncols )
% an error correction strategy for content addressable memory
% has a max of 3000 update iterations before convergence

% set maximum number of iterations and updates
MAX_ITERS = 100;
MAX_UPDATES = 30;

% track the number of iterations
num_iters = 0;

% run loop until max iterations met
while num_iters < MAX_ITERS
  numchanges=0;
  for iupdate=1:MAX_UPDATES
    [AVecRecall,delta] = updateRandomNode(MatrixMem,AVecRecall); %WRITE THIS FUNCTION
    numchanges=numchanges+delta;
  end
  numchanges %print out how many nodes were changed
  
  AmatCorrected=vec2matrix(AVecRecall,nrows,ncols); %convert vector back to matrix

  num_iters = num_iters + 1;
end

% write the corrected memory only once at the end
imwrite(AmatCorrected, ['output/' cue_name]) %and write matrix as a bitmap

end

