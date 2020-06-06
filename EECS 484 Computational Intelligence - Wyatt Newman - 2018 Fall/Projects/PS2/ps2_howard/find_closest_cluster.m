function [closestClust] = find_closest_cluster(ipat,feature_scaled_vals,cluster_centroids)
%find_closest_cluster.m
%given assigned value for ipat, cycle through all clusters and find which
%cluster is closest to ipat.  Resulting cluster index is set in  closestClust
[nclusters,nfeatures]=size(cluster_centroids);
jclust=1;
closestClust=1;

bestdist=norm(feature_scaled_vals(ipat,:)-cluster_centroids(jclust,:));

%bestdist=pdist2(feature_scaled_vals(ipat,:), cluster_centroids(jclust,:), 'cityblock');
%pdist2(feature_scaled_vals(ipat,:), cluster_centroids(jclust,:), 'minkowski');
%pdist2(feature_scaled_vals(ipat,:), cluster_centroids(jclust,:), 'chebychev');

for jclust=2:nclusters
   dPatClust = norm(feature_scaled_vals(ipat,:)-cluster_centroids(jclust,:));
   %pdist2(feature_scaled_vals(ipat,:), cluster_centroids(jclust,:), 'cityblock');
   if (dPatClust<bestdist)
       bestdist=dPatClust;
       closestClust=jclust;
   end
end
%bestdist
%closestClust