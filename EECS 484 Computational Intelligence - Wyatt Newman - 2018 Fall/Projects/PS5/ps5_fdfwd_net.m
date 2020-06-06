%2-layer fdfwd network to be trained w/ custom BP
% author Shaun Howard
%for xor, define 3 inputs, including bias (I=3),  J interneurons (incl bias), and 1 output
%choose logsig (sigmoid) nonlinear activation fnc 
% put training patterns in rows: P=4 patterns
p1=[1,0,0];
t1=[0];
p2=[1,1,1];
t2=[0];
p3=[1,1,0];
t3=[1];
p4=[1,0,1];
t4=[1];
training_patterns=[p1;p2;p3;p4];  %store pattern inputs as row vectors in a matrix
targets=[t1;t2;t3;t4];  % should have these responses; rows correspond to input pattern rows
ndim_inputs=3; %2D patterns plus bias
nnodes_layer1=10; %try this many interneurons--including bias virtual neuron; experiment with this number
nnodes_layer2=1; %single output
%weights from pattern inputs to layer-1 (interneurons)
%initialize weights to random numbers, plus and minus--may want to change
%range; first row has dummy inputs, since first interneuron is unchanging bias node
W1p = (2*rand(nnodes_layer1,ndim_inputs)-1); %matrix is nnodes_layer1 x ndim_inputs

%weights from interneurons (and bias) to output layer 
W21 = (2*rand(nnodes_layer2,nnodes_layer1)-1); %includes row for bias inputs

%evaluate networkover a grid of inputs and plot using "surf"; 
%works only in special case:  assumes inputs are 2-D and range from 0 to 1 
ffwd_surfplot(W1p,W21);
EPS=0.01; % tune this value; may also want to vary this during iterations
MAX_ITERS=5;

iteration=1;
while (iteration<MAX_ITERS) % infinite loop--ctl-C to stop; edit this to run finite number of times
    %compute all derivatives of error metric w/rt all weights; put these
    %derivatives in matrices dWkj and dWji
    [dWkj,dWji]=compute_W_derivs(W1p,W21,training_patterns,targets);

    %DEBUG: uncomment the following and prove that your compute_W_derivs
    %yields the same answer as numerical estimates for dE/dW
    %comment out to run faster, once debugged
    dWkj; %display derivative computation
    est_dWkj=numer_est_Wkj(W1p,W21,training_patterns,targets); %and numerical estimate
    dWji; %display sensitivities dE/dwji
    est_dWji=numer_est_Wji(W1p,W21,training_patterns,targets); %and numerical estimate
    
%     xlswrite('dWkj', dWkj)
%     xlswrite('est_dWkj', est_dWkj)
%     xlswrite('dWji', dWji)
%     xlswrite('est_dWji', est_dWji)
    
    %use gradient descent to update all weights:
    W1p=W1p-EPS*dWji;
    W21=W21-EPS*dWkj;
    
    % plot out progress whenever iteration is multiple of 100 
    if (mod(iteration,100)==0)
        ffwd_surfplot(W1p,W21); 
        iter1k=iteration;
        iteration;
        pause(0.4)
        rmserr=err_eval(W1p,W21,training_patterns,targets);
    end
    
    % increment the iteration number
    iteration=iteration+1;
end
ffwd_surfplot(W1p,W21); %print out final plot, if loop terminates
  