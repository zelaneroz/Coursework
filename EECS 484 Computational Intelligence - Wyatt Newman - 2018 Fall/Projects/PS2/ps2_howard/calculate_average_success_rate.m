%The purpose of this script is to find the average
%success rate of 100 k-means clustering trials.
clear all;

N = 100;

t_success_rates = zeros(N, 1);
v_success_rates = zeros(N, 1);

for k=1:N
    t_success_rates(k) = kmeans_clustering;
    clear kmeans_clustering
    v_success_rates(k) = validate_clusters;
    clear validate_clusters
end

fprintf('Training avg success rate: ');
disp(mean(t_success_rates));

fprintf('Validation avg success rate: ');
disp(mean(v_success_rates));