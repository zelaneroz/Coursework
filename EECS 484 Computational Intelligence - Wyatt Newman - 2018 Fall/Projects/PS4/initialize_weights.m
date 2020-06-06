function weight_matrix = initialize_weights( weight_matrix )
%INITIALIZE_WEIGHTS: A function to initialze the neuron weights of a maxnet
% W is set using unity autapses and mutual
% inhibition of strength eps
% @author Shaun Howard

% epsilon value to linearly and mutually decrease neuron dominance
% epsilon is determined by 0 < eps < 1/n_competitors
EPS = 0.0025;

% get size of weight matrix
matrix_size = size(weight_matrix);

% get number of rows in weight matrix
nrows = matrix_size(1);

% get number of columns in weight matrix
ncols = matrix_size(2);

% iterate through and adjust all weights
for i=1:nrows
   for j=1:ncols
       
       % unity autapse and mutual inhibition influence
       if i == j
           % have each weight influence itself positively
            weight_matrix(i, j) = 1;
       else
           % node i compete with node j in mutual inhibition step
           % of weight initialization
            weight_matrix(i, j) = -EPS;
       end
   end
end

end

