function varargout=circfindpeaks(varargin)
%wrapper for function "findpeaks", but when X is circular data
%
% [PKS]=circfindpeaks(X,args)
% [PKS,LOCS]=circfindpeaks(X,args)
%
% Inputs: 
% X: vector of circular data
% args: cell array of arguments to pass to "findpeaks". Can be empty.
%
% Outputs:
% type "help findpeaks"

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


%input
X=varargin{1};
if ~isvector(X)
    error('X must be a vector')
end

%double up X
n=length(X);
[~,dimcat]=max(size(X));
X=cat(dimcat,X,X);
varargin{1}=X;

%input to findpeaks
[PKS, LOCS]=findpeaks(varargin{:});

%deal with edge fx
edge=n+1;
ind=LOCS<=edge;
if any(LOCS==edge)
    if any(LOCS==1) % if first entry already popped up
        ind(LOCS==edge)=false; %get rid of the nth entry
    else
        LOCS=cat(dimcat,1, LOCS(LOCS~=edge));
    end
end
    
%outputs
PKS=PKS(ind);
LOCS=LOCS(ind);

if nargout>0; varargout{1}=PKS; end
if nargout>1; varargout{2}=LOCS; end


