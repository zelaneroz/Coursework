function found_winner = find_winner( activation_values )
%NO_WINNER_FOUND: Determines if a maxnet winner node was found
% Specific function to determine if a maxnet winning node was found
% in the network. 
% @author Shaun Howard

% if a winner was found, updated when only 1 positive neuron is left
found_winner = 0>1;

% the number of positive neurons left
winners_found = 0;

% get the size of the activation value vector
vec_size = size(activation_values);

% get the number of activation values
nvalues = vec_size(1);

% iterate through and determine the number of positive activation 
% values left in the weight matrix in order to see if one dominations
% the entire neighbor, i.e. is the only positive node left
for i=1:nvalues
       
   % increment the number of positive neurons found
   if activation_values(i) > 0
       winners_found = winners_found + 1;
   end
end

found_winner = winners_found <= 1; 
if found_winner
    fprintf('found a winner!\n');
end
end

