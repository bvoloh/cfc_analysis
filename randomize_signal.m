function newx = randomize_signal(x,randType,highdim)
% randomizes signal for statistical anlaysis
% newx = randomize_signal(x,randType,highdim)

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE


if randType==1
    if highdim
        newx = scramble_phase3(x);
    else
        newx = scramble_phase2(x);
    end
elseif randType==2
    if highdim
        newx = time_splice3(x);
    else
        newx = time_splice2(x);
    end
elseif randType==3
    newx=rand_trl(x);
    
    %may be an inappropriate randomization if matrix is 2D
    if ~highdim; 
        warning('randomizing along third dimension, but dimensionality may be incorrect');
    end
end




function rot = time_splice2(x, sshift)

npoints = length(x);
rot=zeros(size(x));
for n=1:1:size(x,2)
    if nargin < 2
        sshift = floor(0.5*rand*npoints)+1;
    end

    rot(:,n) = [x(sshift:end,n); x(1:sshift-1,n)];
end


function [rot] = time_splice3(x1, sshift)
npoints = length(x1);
rot=zeros(size(x1));

for m=1:1:size(x1,3)
    for n=1:1:size(x1,2)
        if nargin < 2
            sshift = floor(0.5*rand*npoints)+1;
        end

        rot(:,n,m) = [x1(sshift:end,n,m); x1(1:sshift-1,n,m)];
    end
end



function scrambled = scramble_phase2(x)

x = bsxfun(@minus,x,mean(x));
n = size(x,1);
oldn = n;

n2 = nextpow2(n);
n = 2^n2;
x(oldn+1:n,:) = 0;

y = fft(x);

magy = abs(y(2:n/2,:));
randphase=[];
for k=1:1:size(y,2)
    randphase(:,k) = rand(1,n/2-1)*2*pi;
end
y(2:n/2,:) = magy.*exp(1i*randphase);
y((n/2+2):n,:) = conj(y(n/2:-1:2,:));
scrambled = ifft(y);
scrambled = scrambled(1:oldn,:);



function [scrambled] = scramble_phase3(x)
scrambled=nan(size(x));

for nT=1:1:size(x,3)
    x1=x(:,:,nT);
    
    x1 = bsxfun(@minus,x1,mean(x1));
    n = size(x1,1);
    oldn = n;

    n2 = nextpow2(n);
    n = 2^n2;
    x1(oldn+1:n,:) = 0;

    y = fft(x1);

    magy = abs(y(2:n/2,:));
    randphase=[];
    for k=1:1:size(y,2)
        randphase(:,k) = rand(1,n/2-1)*2*pi;
    end
    y(2:n/2,:) = magy.*exp(1i*randphase);
    y((n/2+2):n,:) = conj(y(n/2:-1:2,:));
    tmp = ifft(y);
    scrambled(:,:,nT) = tmp(1:oldn,:);
end


    
function rot=rand_trl(x1)
newind=randperm(size(x1,ndims(x1))); 
rot=x1(:,:,newind);


