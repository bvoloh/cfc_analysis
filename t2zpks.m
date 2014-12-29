function varargout=t2zpks(Z,time,bins)
% Chi-square test on histogram of Rayleigh Z peaks
%
% t2zpks(Z,time,bins)
% [stats] = t2zpks(Z,time,bins)
% [stats,edges] = t2zpks(Z,time,bins)
% [stats,edges,bincentre] = t2zpks(Z,time,bins)
%
% Inputs:
% Z: N*t matrix of Rayleigh Z values, where n=# of LFPs, and t=time points
% time: 1*t vector of the time
% bins: either 1) an integer specifying the number of bin centers, or 
%              2) a vector of the edges of the bins
%
% Outputs:
% stats: structure with fields corresponding to the observed frequency,
%        expected frequency, X2 and p value
% edges: edges of histrogram bins
% bincentre: centre of histogram bins

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

% defaults and initial values
if isinteger(bins)
    nbins=bins;
    edges = linspace(time(1),time(end),nbins+1);
elseif isvector(bins)
    nbins=length(bins)-1;
    edges=bins;
    
    if ~time(1)==edges(1) || ~time(end)==edges(end)
        error('bin edges do not agree with time vector')
    end
else
    error('"bins" must either be an integer specifiying the number of bin centers, or a vector of the edges of the bins')
end
 
bincentre=mean( [edges(1:end-1);edges(2:end)] );
N=size(Z,1);

% index and time of max Rayleigh Z
[~,imax]=max(Z,[],2);
tmax=time(imax);

% find expected and observed frequencies in bins
expected = (N./nbins) .* ones(nbins,1);
observed=hist(tmax,bincentre);

%chi-test
[X2,p]=chitest(expected,observed);

fprintf('Distribution of Rayleigh Z peaks: X2=%.3g,p=%.3g\n',X2,p);


%outputs
if nargout>0; 
    stats.observed=observed;
    stats.expected=expected;
    stats.x2=X2;
    stats.p=p;

    varargout{1}=stats; 
end
if nargout>1; 
    varargout{2}=edges; 
end
if nargout>2; 
    varargout{3}=bincentre; 
end
    