function [pval z] = circ_rtest2(varargin)
%
% [pval, z] = circ_rtest(alpha,w,d,dim)
%   Computes Rayleigh test for non-uniformity of circular data.
%   H0: the population is uniformly distributed around the circle
%   HA: the populatoin is not distributed uniformly around the circle
%   Assumption: the distribution has maximally one mode and the data is 
%   sampled from a von Mises distribution!
%
%   Input:
%     alpha	sample of angles in radians
%     [w		number of incidences in case of binned angle data]
%     [d    spacing of bin centers for binned data, if supplied 
%           correction factor is used to correct for bias in 
%           estimation of r, in radians (!)]
%     [dim  dimension along which to calculate the Rayleigh's Z test
%
%   Output:
%     pval  p-value of Rayleigh's test
%     z     value of the z-statistic
%
% PHB 7/6/2008
%
% References:
%   Statistical analysis of circular data, N. I. Fisher
%   Topics in circular statistics, S. R. Jammalamadaka et al. 
%   Biostatistical Analysis, J. H. Zar
%
% Circular Statistics Toolbox for Matlab

% By Philipp Berens, 2009
% berens@tuebingen.mpg.de - www.kyb.mpg.de/~berens/circStat.html
% BV: JUL-16-2014--> support for matrices

alpha=varargin{1};
if vararginchk(varargin,2); w=varargin{2}; else w=[]; end
if vararginchk(varargin,3); d=varargin{3}; else d=[]; end
if vararginchk(varargin,4); dim=varargin{4}; else dim=1; end


r =  circ_r(alpha,w,d,dim);

if isempty(w)
    n = size(alpha,dim);
else
    n = sum(w);
end


% compute Rayleigh's R (equ. 27.1)
R = n*r;

% compute Rayleigh's z (equ. 27.2)
z = R.^2 / n;

% compute p value using approxation in Zar, p. 617
pval = exp(sqrt(1+4*n+4*(n^2-R.^2))-(1+2*n));

% outdated version:
% compute the p value using an approximation from Fisher, p. 70
% pval = exp(-z);
% if n < 50
%   pval = pval * (1 + (2*z - z^2) / (4*n) - ...
%    (24*z - 132*z^2 + 76*z^3 - 9*z^4) / (288*n^2));
% end









