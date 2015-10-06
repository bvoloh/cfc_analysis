function out = get_mi(lf_phase,hf_env,nbins,nsurr,randType)
% out = get_mi(lf_phase,hf_env,nbins) OR
% out = get_mi(lf_phase,hf_env,nbins,nsurr,randType)
%
% This function calls "calc_mi" to calculate MI values 
% Inputs: 
% - lf_phase/ hf_env are TxN/ TxM sized arrays with phase and amplitude information, respectivley.
%   The first two dimensions are "time-freq". Concatenating trials should 
%   be done along the first dimesions. Alternatively, the matrices can be extended into the 
%   third dimension (for example, for single trials analysis)
% - nbins: number of phase bins (eg 18)
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
% - out: structure with five fields
%        MI: array of MI values, of size=[N,M,# of realizations]
%        MIp: associated p-value (=nan if nargs<4)
%        MIsurrmi: average MI across surroagte MI values (=nan if nargs<4)
%        mean_amps: matrix one dimension higher than out.MI, where the final dimension
%                   corresponds to the average amplitude per phase bin. Useful for
%                   calculating preferred phase
%        ninds: number of instantaneous observations that were used to
%               calculate the MI

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

%CHECKS
%check is randomization stats should be retrieved
if nargin<4; 
    doSurr=false; 
else
    doSurr=true; 
    
    %check what kind of randomizations should be made
    if nargin<5
        error('must specify type of randomization for surrogate stats');
    end

end


%check if amp/ phase matrices have proper dimensions
if ndims(lf_phase) ~= ndims(hf_env) && ...
        size(lf_phase,1) ~= size(hf_env,1) && ... 
        size(lf_phase,3) ~= size(hf_env,3)
    error('mismatched dimensions of phase and ampltiude matrices'); 
end

%check how many dimensions data has, will determine what functions
%subsequently called
if ndims(lf_phase)>2; highdim=true; else highdim=false; end %#ok



%make phase bins
[bins, centers] = make_phase_bins(nbins);


%initialize output: dimensions are "phase freq-amp freq-trial dim
dimtr=3; %dimension for trial
out.MI         = nan(size(lf_phase,2),size(hf_env,2),size(hf_env,dimtr));
out.MIp        = nan(size(lf_phase,2),size(hf_env,2),size(hf_env,dimtr));
out.MIsurrmi   = nan(size(lf_phase,2),size(hf_env,2),size(hf_env,dimtr));

% calculate observed MI
disp('calcualting observed MI...')
[mean_amps, ninds] = wrap_get_amps(lf_phase, hf_env, bins, highdim); %size(mean_amps)= #phase freq, #ampfreq, nbins
uniform = 1/length(centers) .* ones(size(mean_amps)); %calculate here instead of in calc_mi for efficiency
out.MI = calc_mi(centers, mean_amps, uniform);

% calculate surrogate stats
if doSurr
    disp('permutation test...')
    surr_mi = zeros([size(out.MI), nsurr]);

    fn=0;
    for s=1:nsurr
        %updatecounter(s,[1 nsurr],'surrogate run: ')
        disp(['surrogate run # ' num2str(s)])
        
        %randomize signal
        rot_hf_env = randomize_signal(hf_env,randType,highdim);

        [surr_amps, ~] = wrap_get_amps(lf_phase, rot_hf_env, bins, highdim);

        %use linear index to flexibly account for different possible
        %dimensions
        st=fn+1;
        fn=fn+numel(surr_amps)./length(centers);
        
        surr_mi(st:fn) = calc_mi(centers, surr_amps, uniform); %update last
    end
    
    %assign output
    dimsurr=ndims(surr_mi);

    out.MIp       = ( sum(bsxfun(@gt, surr_mi, out.MI),dimsurr)+1 )./(nsurr+1);   
    out.MIsurr    = mean(surr_mi,dimsurr);   
end

%assign outputs
out.mean_amps = mean_amps;  %useful halfstep, can calculate preferred phase later                                                   
out.ninds     = ninds;

disp('...finished MI for one channel pair')