
% Normalisation is the first step in fingerprint enhancement algorithm
% This function normalises a fingerprint.
% Input: im --> the fingerprint to be normalised
% Output: N--> the normalised image


function [N]=normalisation(im)

[m n]=size(im);
im=double(im);
V1=var(im(:)); % estimated variance of im
M1=mean(im(:));% estimated mean of im

M0=0;  % desired mean
V0=1;  % desired variance

% N is the normalised image
% initialising N
N=zeros(size(im));

for i=1:m
    for j=1:n
   
      N(i,j)=M0+sqrt(V0/V1)*(im(i,j)-M1);
          
    end
end

end