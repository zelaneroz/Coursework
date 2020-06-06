% neighborhood fnc; decays with time and space
% returns value of alpha=influence coefficient of current pattern vector on
% cluster at location i,j as well as the influence radius, "radius"
function [alpha,radius]=alphafnc(i,j,ictr,jctr,time,MAX_TIME)
  
    % the maximum neighborhood radius
    MAX_RADIUS = 6;

    % the maximum learning rate
    MAX_ALPHA = 0.5;
    
    % neighborhood radius, which decays linearly with time
    radius=MAX_RADIUS*(1-(time/MAX_TIME));
    
    % compute distance of cluster at i,j from "central" cluster located at
    % ictr,jctr
    points=[ictr,jctr;i,j];
    dist=pdist(points,'euclidean');
    
    % initialize learning rate
    alpha=0;
    
    % only update alpha if cluster is within neighborhood radius
    %if dist <= radius
    % calculate learning rate, which decays linearly with radius
    alpha=MAX_ALPHA*(1-(radius/MAX_RADIUS));
    %end    
end





