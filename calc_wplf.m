function [wplf, ninds]=calc_wplf(lf_phase,hf_env)
% calculates the wPLF (Maris et al 2011)
% [wplf, ninds]=calc_wplf(lf_phase,hf_env)
% inputs: 
%   - lf_phase: analytic (complex-valued) signal
%   - hf_env: amplitude (real-valued) envelope

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

%initialize matrices, dimensions
dimt=1; %time dimension
dimtr=3; %trial dimension
wplf=zeros(size(lf_phase,2), size(hf_env,2), size(hf_env,dimtr));
ninds=wplf;

%mean centre
hf_env2=bsxfun(@minus, hf_env, nanmean(hf_env,dimt));
clear hf_env
lf_phase2=bsxfun(@minus, lf_phase, nanmean(lf_phase,dimt));
clear lf_phase


%ignore nans: putting to zero means entries are not summed during matrix
%multiplication
nanhf=~isnan(hf_env2); 
hf_env2(~nanhf)=0;
nanlf=~isnan(lf_phase2);
lf_phase2(~nanlf)=0;


%normalize--> %manually take norm by sqrt((dot product))
hf_env2=bsxfun(@rdivide,hf_env2,sqrt(dot(hf_env2,hf_env2,dimt))); 
lf_phase2=bsxfun(@rdivide,lf_phase2,sqrt(dot(lf_phase2,lf_phase2,dimt)));


%inner product & divide by # entries--> average wPLF 
for nT=1:size(lf_phase2,dimtr)
    ninds(:,:,nT)= nanlf(:,:,nT)' * double( nanhf(:,:,nT) ); %can be commented out, useful to know how many entires were ignored in calculation
    wplf(:,:,nT)= lf_phase2(:,:,nT)' * hf_env2(:,:,nT) ;
end

