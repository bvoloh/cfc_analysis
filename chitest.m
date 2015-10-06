function varargout=chitest(expected, observed, yates, df)
% Pearson's Chi-squared test (on frequencies)
%
% x=chitest(expect,observe)
% x=chitest(expect,observe,yates,df)
% [x,p]=chitest(...)
%
% Inputs:
% expect: expected frequency
% observe: observed frequency
% yates: (optional) apply Yates correction? (default=false)
% df: (optional) degress of freedom
% NB: entering the empty matrix for optional arguments assigns default values
%
% Outputs:
% x: Chi-square test value
% p: p-value of chi-square test

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


%set values
if nargin<3 || isempty(yates); yates=false; end
if nargin<4 || isempty(df); df=length(expected)-1; end


%checks
if ~isvector(expected); error('"expected" data not vector'); end
if ~isvector(observed); error('"observed" data not vector'); end
if length(observed)~=length(expected); error('vectors must be same length'); end
if sum(size(expected)==size(observed))~=2; expected=expected'; end


% yates correction?
if yates; correction=0.5;
else correction=0;
end


%compute chi stat
x=sum( ( ( abs(observed-expected) - correction ).^2 ) ./ expected );


% p-value
p=1-chi2cdf(x,df);


%set outputs
varargout{1}=x;
if nargout>1; varargout{2}=p; end
