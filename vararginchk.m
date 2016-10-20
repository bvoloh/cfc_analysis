function res = vararginchk(varargin,n)
% simple check if an input argument has been provided

if length(varargin)>n-1 && ~isempty(varargin{n})
    res=true;
else
    res=false;
end


