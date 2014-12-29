function pksphases=get_miphase_peaks(mean_amps,threshold,mpd)
%returns phases of peaks of amplitude distribution. employs wrapper
%function "circfindpeaks"
% 
% pksphases=get_miphase_peaks(mean_amps,threshold)
% pksphases=get_miphase_peaks(mean_amps,threshold,mpd)
%
% Inputs:
% mean_amps: average amplitude in each phase bin
% threshold: value must be >0 and <1. find only those peaks greater than
%            the threshold above the minimum mean_amps value
% mpd: finds peaks that are at least separated by mpd (default=2)
%
% Outputs:
% pksphases: phases of peaks of amplitude distribution

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


%check
if ~isvector(mean_amps); error('mean_amps must be a vector'); end
if ~(threshold>0 && threshold<1); error('threshold must be >0 and <1'); end

%inputs
nbins=length(mean_amps)-1;
if nargin<4; mpd=2; end
mph=min(mean_amps)+threshold*(max(mean_amps)-min(mean_amps)); 

%get peak of amplitude distribution
[~, pksind]=circfindpeaks(mean_amps,'MINPEAKDISTANCE',mpd,'MINPEAKHEIGHT',mph);

%get phases of peaks
[~, centers] = make_phase_bins(nbins);
pksphases=centers(pksind);