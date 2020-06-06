%remove_pattern_from_cluster.m  YOU NEED TO WRITE THIS
%MAY EMULATE put_pattern_into_cluster
%operates on indices current_cluster and ipat
%affects pattern_assignments,
%cluster_rosters, 
%cluster_populations
%cluster_attributes 
%cluster_centroids

%unassign if and only if pattern is currently assigned
%or need to change assignment
 
current_cluster=pattern_assignments(ipat);
if (current_cluster>0) %remove only if currently assigned    
    %update cluster population to one less member
    newpop=cluster_populations(current_cluster)-1;
    cluster_populations(current_cluster)=newpop;
    
    %gather attributes for averaging
    old_attribute=cluster_attributes(current_cluster);
    new_attribute=attributes(ipat); %attribute value of pattern ipat
    
    %recalculate attribute and centroid
    %remove influence of pattern to cluster
    cluster_attributes(current_cluster) = ...
         old_attribute*(newpop+1)/newpop-new_attribute/newpop;

    cluster_centroids(current_cluster,:)=...
        cluster_centroids(current_cluster,:)*(newpop+1)/newpop ...
        - feature_scaled_vals(ipat,:)/newpop; %include influence of weighted avg of new pattern features

    cluster_rosters(current_cluster, ipat)=0; %remove this pattern from the current_cluster's roster
    
    pattern_assignments(ipat)=0; %unassign pattern ipat from any cluster 
end  %end if--which may complete addition to this cluster


