function [feature_scaled_vals] = scale_all_feature_values(feature_max_vals,feature_min_vals,raw_features)
%scale_all_feature_values.m
% (val-minval)/(maxval-minval)
% uses training_data, feature_max_vals and feature_min_vals and populates
% feature_scaled_vals, puts in range 0 to 1
feature_scaled_vals = raw_features*0;
[npatterns,nfeatures]=size(raw_features) %number of rows is number of patterns in training set

for ifeature=1:nfeatures
    maxval =  feature_max_vals(ifeature);
    minval = feature_min_vals(ifeature);
    for jpattern=1:npatterns
        rawval=raw_features(jpattern,ifeature);
        feature_scaled_vals(jpattern,ifeature)=(rawval-minval)/(maxval-minval);
    end %done w/ this feature for all patterns
end %done w/ all patterns
        