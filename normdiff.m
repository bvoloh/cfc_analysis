function d=normdiff(a,b)
% d=normdiff(a,b)
% d=(b-a)./(b+a);

% Copyright 2014, Benjamin Voloh
% Distributed under a GNU GENERAL PUBLIC LICENSE

%calculate difference
d=(b-a)./(b+a);

%set entries where b and a are zero to zero
d(b==0 & a==0)=0;
