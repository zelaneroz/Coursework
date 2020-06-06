function [feature_max_vals,feature_min_vals] = find_minmax_feature_vals(raw_features)
%find_minmax_feature_values.m
%comb through all values of each feature for all patterns and find and record peak for each
%feature;  uses training_data and populates feature_max_vals and
%feature_min_vals
[npatterns,nfeatures]=size(raw_features) %number of rows is number of patterns in training set

feature_max_vals=raw_features(1,:); %init to pattern 1 vals
feature_min_vals=raw_features(1,:); %same for min vals
for ifeature=1:nfeatures
    for jpattern=1:npatterns
        testval=raw_features(jpattern,ifeature);
        if (testval>feature_max_vals(ifeature))
            feature_max_vals(ifeature)=testval;
        end %end "if" for max test
        if (testval<feature_min_vals(ifeature))
            feature_min_vals(ifeature)=testval;
        end %end "if" for min test
    end %end pattern loop
end %end feature loop
