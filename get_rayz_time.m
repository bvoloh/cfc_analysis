function [P,Z]=get_rayz_time(X,dim)
% Determines phase consistency (Rayleigh's Z) in time across trials
%
% [P,Z]=get_rayz_time(X)
% [P,Z]=get_rayz_time(X,dim)
% 
% Input:
% X: ND array of phases. The test is performed along dimension 2 by default 
%    (coressponding to a 2D matrix of time x trials). If trials are along 
%    another dimension, supply a "dim" value
% dim: dimensions along which to compute the Rayleigh Z stat (default=2)
%
% Output:
% P: p-values associated with each time point
% Z: Rayleigh's Z associated with each time point

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

if nargin<2; dim=2; end

[P,Z]=circ_rtest2(X,[],[],dim);

