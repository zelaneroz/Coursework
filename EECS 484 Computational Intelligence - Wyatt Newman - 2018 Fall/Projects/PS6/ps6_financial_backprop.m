%2-layer fdfwd network to be trained w/ neural-net toolbox
%for xor, define 2 inputs--bias is implicit J interneurons (not incl bias), and 1 output
%choose tansig (sigmoid) nonlinear activation fnc for hidden layer, linear activation fnc
% for output layer
% put training patterns in rows: P=4 patterns

%note: all  M-file scripts and data files must reside in the same directory.
clear all %make sure all variables from any previous runs are deleted

%start by loading training data
%read in training data--227 companies from S&P 500 with data from Q1 of
%2008; attributes for these companies are stock-price increase percentages
%from Q1 to Q2.                       
training_data = xlsread('SP_training_data_Q1_w_dpriceQ2.csv');

%use features from Q1 to try to predict stock-price change from Q1 to Q2

%normalized features are in cols 15 to 22
raw_features=training_data(:,15:22);
attributes=training_data(:,23); % percent increase (decrease) in stock price is in col 23

temp = size(raw_features); %examine number of patterns and number of features
npatterns = temp(1); %number of rows is number of patterns in training set
nfeatures = temp(2); %number of feature values

%need to normalize all features w/rt min and max vals within training set
%vector to store max value of each feature
feature_max_vals=raw_features(1,:); %init to pattern 1 vals
feature_min_vals=raw_features(1,:); %same for min vals

%variable to hold features after scaling--initialized to all zeros
feature_scaled_vals=zeros(npatterns,nfeatures); %scaled feature values

find_minmax_feature_vals %invoke this m-fnc to populate feature_max_vals
% and feature_min_vals

%normalize the training patterns
scale_all_feature_values %and this to populate feature_scaled_vals

targets=attributes;  % should have these responses; rows correspond to input pattern rows
ndim_inputs=2; %2D patterns--not counting bias
nnodes_layer1=10; %try this many interneurons--not including bias
nnodes_layer2=1; %single output

% be cautious of rows vs columns for input matrices and
% fill in the necessary arguments to build a network object
net=feedforwardnet(nnodes_layer1);
net=init(net); %init all W values; READ ABOUT INIT(NET)

% makes sure that matlab uses all data for training
net.divideFcn='dividerand';
net.divideParam.trainRatio=0.5;
net.divideParam.valRatio=0;
net.divideParam.testRatio=0.5; 

% set the training function
net.trainFcn='traincgf';  %'traingdx'; 'trainrp'; %'trainlm';
%net.trainParam.epochs=2000;

% set the transfer functions between layers
net.layers{1}.transferFcn='tansig';
net.layers{2}.transferFcn='purelin'; %'tansig'

% do NN training
[net,tr,Y,~,~,~]=train(net,feature_scaled_vals',targets');  

% plot out the result--create a new set of stimulus patterns at regular
% intervals and simulate network

%read in the validation data--51 companies not included in the previous
%clustering
validation_data=xlsread('SP_validation_data_Q1_w_dpriceQ2.csv');
raw_features=validation_data(:,15:22); %overwrites training-data raw features
val_attributes=validation_data(:,23); % percent increase (decrease) in stock price for validation data;
% note--DO NOT USE this data for stock picks (that would be cheating).
% Rather, use this data to score how well (or how poorly) the clustering
% algorithm performed in terms of picking winners from the validation pool

%expected return (per quarter) if invest uniformly over all 51 validation
%companies.  This is the number to beat through a more discriminating
%choice of investments:
index_return_avg = mean(val_attributes);

temp = size(raw_features); %examine number of patterns and number of features in validation set
npatterns = temp(1); %number of rows is number of patterns in validation set
%nfeatures = temp(2) %number of feature values--had better be same as
%training set!
%scale the validation features--overwrites feature_scaled_vals
feature_scaled_vals=zeros(npatterns,nfeatures); %to hold scaled feature values of validation data
scale_all_feature_values %populate feature_scaled_vals w/ vaidation features, scaled using
%same min/max feature values as used for the training data clustering

%SIMULATE the network with new input patterns--READ ABOUT "sim()"
[simOutputs,Pf,Af,E,perf]=sim(net,feature_scaled_vals'); %simulate the entire set

%COMPUTE THE CORRESPONDING RETURN ON INVESTMENT FOR THESE COMPANIES
%USING THE CORRESPONDING ATTRIBUTE VALUES

population = 0;
pats_to_choose = zeros(npatterns,1);
pat_return_rates = zeros(npatterns,1);

%find average return rate of investments on validation data
for ipat=1:npatterns
    pred_return_rate = simOutputs(ipat);
    %choose the patterns with a predicted return rate of > 10% gain
    if pred_return_rate > 0.1
        pats_to_choose(ipat) = 1;
        pat_return_rates(ipat) = val_attributes(ipat);
        population = population + 1;
    end
end

%calculate average return rate if population > 0
if population > 0
    avg_return_rate = sum(pat_return_rates) / population;
else
    avg_return_rate = 0.0;
end

fprintf('avg return rate is: %f\n', avg_return_rate);

if avg_return_rate > index_return_avg 
    fprintf('you have chosen winning investments\n')
else
    fprintf('you have chosen losing investments\n')
end

%clear figure window if one is open
clf;

%plot the predicted and actual return on investments for 51 val. companies
plot(1:npatterns, simOutputs, '-xb'); %prediction data is blue line
hold on
plot(1:npatterns, val_attributes', '-og'); %actual data is green line
title('Predicted and Actual Return on Investment')
xlabel('Validation Company Number')
ylabel('Rate of Return on Investment')