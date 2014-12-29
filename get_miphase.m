function miphase=get_miphase(mean_amps,ninds)
% calculate preferred phase of coupling from MI amplitude distribution
%
% miphase=get_miphase(mean_amps,ninds)
%
% Inputs:
% mean_amps: average amplitude in each phase bin
% ninds: number of entries that went into each bin (useful if oncatenated
%        different number of trials)
%
% Outputs:
% miphase: weighted circular mean of amplitude distribution

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


%initialize values
nd=ndims(mean_amps);
nbins=size(mean_amps,nd)-1;
[~, centers] = make_phase_bins(nbins);
reshapecenters=[ones(1,nd-1),length(centers)];


%calculate mean angle
tmp=bsxfun(@times,ninds.*mean_amps,exp(1i*reshape(centers,reshapecenters)));
miphase=angle(nansum(tmp,ndims(tmp)));