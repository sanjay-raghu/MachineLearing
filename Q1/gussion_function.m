function [ lol ] = guss(x,u,sig )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
n=length(x);
d=double(det(sig));
in=double(sig\eye(n));

lol=double((1/((2*pi)^(n/2)))*(1/(d^.5))*exp(-.5*(x-u)*in*(x-u)'));
end

