function [MI] = calc_mi(centers, mean_amps, Q)
% calcuates MI based on the KL distance (Tort et al 2010)
% [MI] = calc_mi(centers, mean_amps, uniform)
%
% inputs: 
%   - centres: phase bin centres
%   - mean_amps: average amplitude per phase bin
%   - Q: hypothesized (eg uniform) distribution
% outputs:
%   - MI: normalized KL distance

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

nd=ndims(mean_amps);

% normalize mean_amps to make a probability-like distribution
P = bsxfun( @rdivide, mean_amps, nansum(mean_amps,nd) ); 

% MI=normalized KL distance
MI = KL_distance2(P,Q) ./ log10(length(centers));


function [D] = KL_distance2(P, Q)

% if size(P,1) ~= size(Q,1)
%     D = 0;
%     return
% end

D = nansum( P .* log10(P./Q) , ndims(P) );
