function wplfphase=get_wplfphase(wplf)
% calculate preferred phase of coupling from the wplf
%
% wplfphase=get_wplfphase(mean_amps,ninds)
%
% Inputs:
% wplf: complex array of wPLF values
%
% Outputs:
% wplfphase: angle of wPLF entires

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

%complex check
if ~iscomplex(wplf); error('Input array must be complex'); end

%calculate
wplfphase=angle(wplf);