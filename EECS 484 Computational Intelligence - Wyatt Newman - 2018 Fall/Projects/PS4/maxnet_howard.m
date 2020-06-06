% maxnet simulation: for nnodes number of nodes, each node has a unity
% autapse and every pair of nodes has mutual inhibition of strength eps (<0)
% start w/ random initialization of the neural outputs, sigma_vec, then
% simulate the evolution of the network (with implicit time constant = 1)
% activiation function is assumed to output zero for any negative input, but
% is linear (with slope=1) for any non-negative input

clear all %delete any old variables still hanging around
figure(1) %clear figure 1 for display
clf %clear the current figure

nnodes = 100; %choose a number of interconnected nodes
W=ones(nnodes,nnodes); %need to populate weight matrix--start w/ all ones

% W is set using unity autapses and mutual
% inhibition of strength eps
W = initialize_weights(W);

%initialize a set of outputs:
sigma_vec = rand(nnodes,1);
sigma_history=[sigma_vec];

%create time vector to enable plotting
time =0;
time_vec=[time];

%plot evolution of all outputs up to this point...
figure(1)
clf

%allow adding new data to figure 1
hold all
for i=1:nnodes
    plot(time,sigma_vec(i))
end

% update the activation values of maxnet nodes
% until a winning node is found with the last positive activation value
while ~find_winner(sigma_vec)
    
    % implicitly sets the time delay of each neuron
    % (stimulus to response) to be 1 unit
    time=time+1;  
    
    time_vec=[time_vec,time]; %add an element to the time vector
 
    % net inputs are tracked because the update process for a maxnet
    % is an iterative process that updates activation values until the net
    % stabilizes (all but one neuron have negative activation value. 
    % Hence, the net will have at most one neuron with a positive
    % activation value which is our winner.
    net_inputs = W*sigma_vec;

    % for each neuron, compute firing rate as a function of net voltage at soma
    for i=1:nnodes
        sigma_vec(i)=activation_fnc(net_inputs(i)); %outputs follow from inputs and activation fnc
    end
    
    %display the output values
    sigma_vec 
    
    %keep track of this for plotting history
    sigma_history=[sigma_history,sigma_vec]; 
 
    %rest of this is just plotting--overwrite the figure to show current status
    hold off %clear the figure
    clf
    hold all %allows adding multiple lines to the plot
    
    for i=1:nnodes
        %strip off i'th row of neural responses (for i'th neuron's responses)
        y_vec=sigma_history(i,:); 
        
        %plot this neural response vs time
        plot(time_vec,y_vec) 
    end
    
    title('Maxnet time history of outputs')
    xlabel('time')
    ylabel('sigma outputs')
    
    % done with plot
    % pause %for single-stepping; user must hit "enter" to continue with next iteration
end

fprintf('Number of Neurons in Maxnet: %d\n', nnodes);
fprintf('Time taken to converge: %d iterations\n', time);


    
        
