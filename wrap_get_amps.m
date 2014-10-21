function [mean_amps, ninds]=wrap_get_amps(lf_phase, hf_env, bins, highdim)
% extracts mean amplitde per phase bins
% [mean_amps, ninds]=wrap_get_amps(lf_phase, hf_env, bins, highdim)
%
% Inputs:
%       - lf_phase: TxN array of phases, where T=# of time points and 
%                   N= # of frequencies
%       - hf_env: TxM array of amplitude envelopes, where 
%                 T=# of time points and M= # of frequencies
%       - bins: 2xN array of phase bins, where N= # of phase bins
%       - highdim= rtue or false, determines which functions are called
%
% Outputs:
%       - mean_amps: NxM array of average amplitude in each pahse bin
%       - ninds: number of observations used for each entry of mean_amps

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

if highdim
    [mean_amps, ninds] = get_amps3(lf_phase, hf_env, bins);
else
    [mean_amps, ninds] = get_amps2(lf_phase, hf_env, bins);
end



function [mean_amps, ninds] = get_amps2(lf_phase, hf_env, bins) 

nbins = length(bins);
mean_amps = zeros(size(lf_phase,2), size(hf_env,2), nbins); %dim=n_phase,n_amp,n_bins
ninds = mean_amps;
%
for i=1:nbins
    ind = sparse( lf_phase >= bins(1,i) & lf_phase < bins(2,i) )';
    notnan = ~isnan(hf_env);

    ninds(:,:,i) = ind*double(notnan);
    hf_env(~notnan)=0;
    mean_amps(:,:,i) = ( ind*hf_env )./ninds(:,:,i);
end

%set mean amp to 0 if we found no instance of phase in a particular bin
mean_amps(ninds==0)=0;




function [mean_amps, ninds] = get_amps3(lf_phase, hf_env, bins)
nbins = length(bins);
mean_amps = zeros(size(lf_phase,2), size(hf_env,2), size(hf_env,3), nbins); %dim=n_phase,n_amp,n_bins
ninds = mean_amps;

notnan = ~isnan(hf_env);
hf_env(~notnan)=0;
for ii=1:nbins
    ind = ( lf_phase >= bins(1,ii) & lf_phase < bins(2,ii) );
    for nT=1:size(hf_env,3)
        ninds(:,:,nT,ii) = ind(:,:,nT)'*double(notnan(:,:,nT));
        mean_amps(:,:,nT,ii) = ( ind(:,:,nT)'*hf_env(:,:,nT) )./ninds(:,:,nT,ii);
    end
end

%set mean amp to 0 if we found no instance of phase in a particular bin
mean_amps(ninds==0)=0;