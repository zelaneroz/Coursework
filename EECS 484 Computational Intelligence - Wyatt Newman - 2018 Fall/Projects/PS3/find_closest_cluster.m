%function find_closest_cluster()
% Uses the dot product between invec and all cluster feature vectors
% in order to find which cluster feature vector is most similar.
function [ibest,jbest]=find_closest_cluster(invec,clusters)

    [nrows,ncols,vecdim]=size(clusters);
    
    ibest=1;
    jbest=1;
    best_dist=inf;

    % find the cluster feature vector closest to invec
    for i=1:nrows
        for j=1:ncols
            curr_dist=dot(invec,squeeze(clusters(i,j,:)));
            if curr_dist < best_dist
               best_dist=curr_dist;
               ibest=i;
               jbest=j;
            end
        end
    end
end


        