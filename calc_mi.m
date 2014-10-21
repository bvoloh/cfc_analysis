function [MI] = calc_MI(centers, mean_amps, uniform)
%calcuates MI based on the KL distance (Tort et al 2010)

nd=ndims(mean_amps);

% normalize mean_amps to make a probability-like distribution
P = bsxfun( @rdivide, mean_amps, nansum(mean_amps,nd) ); 

%hypothetical uniform distribution
MI = KL_distance2(P,uniform) ./ log10(length(centers));


function [D] = KL_distance2(P, Q)

% if size(P,1) ~= size(Q,1)
%     D = 0;
%     return
% end

D = nansum( P .* log10(P./Q) , ndims(P) );
