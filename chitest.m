function varargout=x2test(observed, yates, df, expected)
% Pearson's Chi-squared test (on frequencies)
%
% x=chitest(observed)
% x=chitest(observed,yates,df)
% x=chitest(observed,yates,df,expected)
% [x,p]=chitest(...)
%
% Inputs:
% observe: observed frequency
% yates: (optional) apply Yates correction? (default=false)
% df: (optional) degress of freedom. See code for how its calculated
% observe: (optional) expected frequency
% *NB* entering the empty matrix for optional arguments assigns default values
%
% Outputs:
% x: Chi-square test value
% p: p-value of chi-square test

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


%set values
if nargin<2 || isempty(yates); yates = false; end
if nargin<3 || isempty(df); 
    if isvector(observed); df = numel(observed)-1; %Chi2 goodness of fit
    else df = prod( size(observed)-1 ); %chi2 test for independence
    end
end
if nargin<4 || isempty(expected); calcExpected = 1; else calcExpected = 0; end

% yates correction?
if yates; correction = 0.5;
else correction = 0;
end

%get expected values
if calcExpected
    s1 = sum(observed,1);
    s2 = sum(observed,2);
    expected = s2*s1./sum(sum(observed));
end

%vectorize
expected = expected(:);
observed = observed(:);

%compute chi stat
x = sum( ( ( abs(observed-expected) - correction ).^2 ) ./ expected );
p = 1-chi2cdf(x,df);


%set outputs
varargout{1} = x;
if nargout>1; varargout{2} = p; end
