%function find_best_matching_cluster()
% Uses the euclidean distance between invec and all cluster feature vectors
% in order to find which cluster is most similar.
function [ibest,jbest]=find_best_matching_cluster(invec,clusters)

    [nrows,ncols,vecdim]=size(clusters);
    
    distances = zeros(nrows, ncols);

    % find the cluster with feature vector closest to invec
    for i=1:nrows
        for j=1:ncols
            distances(i,j)=norm(invec-squeeze(clusters(i,j,:)));
        end
    end
    
    [min_val,idx]=min(distances(:));
    [ibest,jbest]=ind2sub(size(distances),idx);
end


        