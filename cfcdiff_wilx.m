function [stat,p]=cfcdiff_wilx(a,b,amask,bmask)
% Wilcoxon signed-rank test on normalized difference in CFC
%
% [stat,p]=cfcdiff_wilx(a,b)
% [stat,p]=cfcdiff_wilx(a,b,amask,bmask)
%
% normalized difference=(b-a)/(b+a). If logical matrices amask and bmask
% are supplied, then they are used to mask a and b to zero, respectivley.

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

%inputs
if nargin>2
    %logic check
    if ~islogical(amask) || ~islogical(bmask)
        error('ap and bp must be logical')
    else
        surrMask=1;
    end
end
    
%mask non-significant values to zero
if surrMask
    a(~amask)=0;
    b(~bmask)=0;
end

%calculate normalized difference
d=normdiff(a,b);

%statistical testing for each freq-freq pair 
for n=1:size(d,1)
    for m=1:size(d,2)
        [p(n,m),~,tmp]=signrank(squeeze(d(n,m,:)));
        stat(n,m)=tmp.signedrank; %OR .zval
    end
end

% FDR correction
alpha=0.05;
[p,~]=bonf_holm(p,alpha);


