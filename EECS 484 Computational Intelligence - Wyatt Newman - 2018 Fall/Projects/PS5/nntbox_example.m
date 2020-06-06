%example using NN toolbox...
%2-layer fdfwd network to be trained w/ neural-net toolbox
%for xor, define 2 inputs--bias is implicit J interneurons (not incl bias), and 1 output
%choose tansig (sigmoid) nonlinear activation fnc for hidden layer, linear activation fnc
% for output layer
% put training patterns in rows: P=4 patterns
p1=[0,0];
t1=[0];
p2=[1,1];
t2=[0];
p3=[1,0];
t3=[1];
p4=[0,1];
t4=[1];
training_patterns=[p1;p2;p3;p4];  %store pattern inputs as row vectors in a matrix
targets=[t1;t2;t3;t4];  % should have these responses; rows correspond to input pattern rows
ndim_inputs=2; %2D patterns--not counting bias
nnodes_layer1=4; %try this many interneurons--not including bias
nnodes_layer2=1; %single output

ranges=[0 1; 0 1]; %define 2-D input patterns, values range 0 to 1

% be cautious of rows vs columns for input matrices and
% fill in the necessary arguments to build a network object
net=feedforwardnet(nnodes_layer1);
net=init(net); %init all W values; READ ABOUT INIT(NET)

% makes sure that matlab uses all data for training
net.divideFcn='dividetrain';

% set the training function
net.trainFcn='traincgf';  %'trainrp'; %'trainlm';

% set the transfer functions between layers
net.layers{1}.transferFcn='tansig';
net.layers{2}.transferFcn='purelin'; %'tansig'

% do NN training
[net,tr,Y,~,~,~]=train(net,training_patterns',targets');  

% plot out the result--create a new set of stimulus patterns at regular
% intervals and simulate network
evalpats=[];
for i=0:0.1:1
    for j=0:0.1:1
     evalpats=[evalpats,[i;j]];
    end
end
xvals=0:0.1:1; %same stimulus patterns represented as vectors
yvals=0:0.1:1;

%SIMULATE the network with new input patterns--READ ABOUT "sim()"
[simOutputs,Pf,Af,E,perf]=sim(net,evalpats); %simulate the entire set

%pack the outputs into an array for surface plotting--only works for 2-D in, 1-D out
Z=zeros(11,11);
p=1;
for i=1:11
    for j=1:11
     Z(i,j)=simOutputs(p);
     p=p+1;
    end
end
figure(2)
surf(xvals,yvals,Z) %plot out the result
title('XOR training result')