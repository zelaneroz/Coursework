% computes derivatives w/rt weights for BP
% author Shaun Howard
function [dWkj,dWji] = compute_W_derivs(Wji,Wkj,training_patterns,targets)
dWji=0*Wji; % sets dimensions of output matrices
dWkj=0*Wkj;

temp=size(targets);
P=temp(1); % number of training patterns
K=temp(2); % number of outputs
temp=size(Wji);
J=temp(1); % number of interneurons
I=temp(2); % dimension of input patterns

% loop over all input patterns and compute influence of each pattern on
% dE/dw; do this in a loop to save computations for reuse.
for p=1:P
    % extract p'th training input
    stim_vec= training_patterns(p,:)';
    
    % perform a network simulation with current values of W's
    % need to know outputs of both j and k layers for stimulus pattern p to
    % compute dE/dwji
    [outputj,outputk]=eval_2layer_fdfwdnet(Wji,Wkj,stim_vec);
    
    % compute contribution of this pattern to all elements of Wkj and Wji
    % backpropagates error from the K layer neurons to the J and I layers
    for k=1:K %compute influence w/rt output node k
        % error for output k vs target k
        err_k=outputk(k)-targets(p,k); 
        
        % slope of activation fnc for neuron k for pattern p
        gprime_k=outputk(k)*(1-outputk(k)); 
        
        % compute the new direction of influence of neuron k on j
        new_direction=err_k*gprime_k*outputj';
        
        % calculate influence of neuron k on j
        dWkj(k,:)=dWkj(k,:)+new_direction;
        
        % feedforward the backpropagation by calculating 
        % gprime_j in an inner loop for dE/dwji terms
        % and thus the influence of interneuron j on neuron i
        for j=1:J
           % slope of activation fnc for neuron j for pattern p
           gprime_j=outputj(j)*(1-outputj(j));
                      
           % compute the new direction of influence of neuron j on i
           new_direction=Wkj(k,j)*err_k*gprime_k*gprime_j*stim_vec';
           
           % calculate influence of neuron j on i
           dWji(j,:)=dWji(j,:)+new_direction;
        end 
    end %done w/ loop over all K output neurons
end %done evaluating influence of all P stimulus patterns
