function stats_anatomy(nall,ocouple)
% Pearson's chi-square test and Z-score for proportions on
% adjacency matrix. 
%
% stats_anatomy(nall,ocouple)
% 
% Inputs:
% nall: adjacency matrix of all recorded LFP pairs
% ocouple: adjacency matrix of LFP pairs with observed coupling
%
% Area for phase must be along rows, area for amplitude must be along columns.
% Results of the statistical tests will be displayed in the command window.

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


% number of observed and expected coupling LFP pairs
% this is essentially a (# areas) x (# areas) x(couple or no couple?)
% contingency table
onocouple=nall-ocouple;
ecouple=nall.*( sum(sum(ocouple))./sum(sum(nall)) );
enocouple=nall-ecouple;

%chi-square and Z-score test across all area-pairs
ss=[size(nall) 2];   
df=(ss(1)-1)*(ss(2)-1)*(ss(3)-1) + (ss(1)-1)*(ss(3)-1) + (ss(2)-1)*(ss(3)-1) +( ss(1)-1)*(ss(2)-1);

str='ALL';
chisq_test(ocouple,onocouple,ecouple,enocouple,df,str)
z_test(nall,ocouple,ecouple,str)

%prepare cross area data
nall_within=diag(nall);
ocouple_within=diag(ocouple);
onocouple_within=diag(onocouple);
ecouple_within=diag(ecouple);
enocouple_within=diag(enocouple);

for n=1:2 %first dimension=phase, second dimension=amplitude
    if n==1; ind=[1 ss(1)]; %change so that dimensions at subtraction agree
    else ind=[ss(1),1];
    end
    
    nall_cross=sum(nall,n) - reshape(nall_within,ind);
    ocouple_cross=sum(ocouple,n) - reshape(ocouple_within,ind);
    onocouple_cross=sum(onocouple,n) - reshape(onocouple_within,ind);
    ecouple_cross=sum(ecouple,n) - reshape(ecouple_within,ind);
    enocouple_cross=sum(enocouple,n) - reshape(enocouple_within,ind);
    
    
    %chi-square and Z-score test across inter-area area-pairs
    df=length(nall_cross)-1;

    str='CROSS-AREA';
    if n==1; str=['PHASE-' str];
    else str=['AMPLITUDE-' str];
    end
    
    chisq_test(ocouple_cross,onocouple_cross,ecouple_cross,enocouple_cross,df,str)
    z_test(nall_cross,ocouple_cross,ecouple_cross,str)
end






% --------------
% FUNCTIONS
% --------------

function chisq_test(ocouple,onocouple,ecouple,enocouple,df,str)
% all props distirbution stats
fprintf('\n*** chi-sq test for distribution of %s area-pairs ***\n',str)

o=[ocouple(:); onocouple(:)];
e=[ecouple(:); enocouple(:)];


[x,p]=chitest(e,o,[],[],df);

str=sprintf('df=%.2g, X2=%.4g, p=%.4g',df,x,p);
disp(str)


function z_test(nall,ocouple,ecouple,str)
%zscore each area pair
fprintf('\n*** individual z-score (and p-val) for %s area-pairs ***\n',str)

prop=ocouple./nall;
prop0=ecouple./nall;

%yates correction where number of samples less than 5
correction=0.5./nall;
correction(nall>5)=0;
Z=( (prop - prop0) - correction) ./ sqrt( prop0.*(1-prop0)./nall );

%standardize display
if isvector(Z) && ~isrow(Z); Z=Z'; end
p=z2p(Z);

%display results
disp('Zscores')
disp(Z)
fprintf('\np-values\n')
disp(p)


%mcnemar test
% use mcnemar.m
% http://www.mathworks.com/matlabcentral/fileexchange/15472-mcnemar-est/content/mcnemar.m


