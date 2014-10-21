function out = get_wplf(lf_phase,hf_env,nsurr,randType)
% out = get_wplf(lf_phase,hf_env) OR
% out = get_wplf(lf_phase,hf_env,nsurr,randType)
%
% This function calls "calc_wplf" to calculate wPLF values
%
% Inputs:
% - lf_phase/ hf_env are TxN/ TxM sized arrays with phase and amplitude information, respectivley.
%   The first two dimensions are "time-freq". Concatenating trials should 
%   be done along the first dimesions. Alternatively, the matrices can be extended into the 
%   third dimension (for example, for single trials analysis)
% - nsurr (optional): number of randomizations 
% - surrType (optional): either 1,2,3; specifes type of randomization
%       - 1 = scramble phase: (added in later release) phase of low frequency
%       signal is scrambled by taking the inverse FFT. This opertion
%       preserves the power spectrum of the signal.
%       - 2 = timesplice: randomly partitions signal into 2 slices, and
%       rearranges the order of these slices
%       - 3 = randtrial: random permutation of trials of the amplitude signal
%
% Outputs:
% - out: structure with the following fields
%       wplf: wPLF value (complex valued), of size=[N,M,# of realizations]
%       wplfp: associated p-value, same size as above
%       wplfsurr: average of surrogate wPLFs

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


%CHECKS
%check is randomization stats should be retrieved
if nargin<3; 
    doSurr=false; 
else
    doSurr=true; 
    
    %check what kind of randomizations should be made
    if nargin<4
        error('must specify type of randomization for surrogate stats');
    end

end


%check if amp/ phase matrices have proper dimensions
if ndims(lf_phase) ~= ndims(hf_env) && ...
        size(lf_phase,1) ~= size(hf_env,1) && ... 
        size(lf_phase,3) ~= size(hf_env,3)
    error('mismatched dimensions of phase and ampltiude matrices'); 
end

%check how many dimensions data has, will determine what randomization functions
%subsequently called
if ndims(lf_phase)>2; highdim=true; else highdim=false; end %#ok


%initialize output: dimensions are "phase freq-amp freq-trial dim
out.wplf=[];
out.wplfp        = nan(size(lf_phase,2),size(hf_env,2),size(hf_env,3));
out.wplfsurr     = nan(size(lf_phase,2),size(hf_env,2),size(hf_env,3));
out.ninds        = nan(size(lf_phase,2),size(hf_env,2),size(hf_env,3));

% calculate observed wPLF
[out.wplf, out.ninds]=calc_wplf(lf_phase,hf_env);

% calculate surrogate stats
if doSurr
    surr_wplf = zeros([size(out.wplf), nsurr]);

    fn=0;
    for s=1:nsurr
        %updatecounter(s,[1 nsurr],'surrogate run: ')

        %randomize signal
        rot_hf_env = randomize_signal(hf_env,randType,highdim);

        [sWPLF, ~]=calc_wplf(lf_phase,rot_hf_env);


        %use linear index to flexibly account for different possible
        %dimensions
        st=fn+1;
        fn=fn+numel(sWPLF);
        
        surr_wplf(st:fn)=sWPLF;
    end
end

%assign outputs
dimsurr=ndims(surr_wplf);

out.wplfp    = ( sum(bsxfun(@gt, abs(surr_wplf), abs(out.wplf)),dimsurr)+1 )./(nsurr+1);   %see "Jakulin and Bratko, 2004: 
out.wplfsurr = mean(abs(surr_wplf),dimsurr); 

disp('...finished wPLF for one channel pair')