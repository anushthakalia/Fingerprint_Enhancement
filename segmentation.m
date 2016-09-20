

% This function is the second step in fingerprint enhancement.
% The image is segmented so that unwanted parts of the image 
% are removed, such that no false minutiae during minutiae
% detection are detected.
% The image is first divided into blocks and then segmentation
% is performed.
% Input: im       --> normailsed image
%        threshold--> minimum variance 
%        blksze   --> size of a block in im 
% Output: imsegment --> the segmented image
%         immask    --> mask (binary image)
%assumed values: threshold = 0.02
%                blksze    = 10

function [imsegment,immask]=segmentation(im,threshold,blksze)


[m n]=size(im);

imsegment=zeros(m,n);
immask=zeros(m,n);

S=zeros(blksze,blksze);
Mask=zeros(blksze,blksze);

S=double(S);
Mask=double(Mask);

for i=1:k:m
    for j=1:k:n
        
       S=im(i:i+k-1,j:j+k-1); % taking one block
          
       V=var(S(:));           % variance of intensities of block
       
          
       if V<threshold         % if variance of the block less than
           S=1;               % threshold, discarding that block
           Mask=0;            
       else 
           Mask=1;            % if variance greater than the threshold
       end                    % then keeping that block and in the mask
                              % assigning that block a value of 1.
                              
       imsegment(i:i+k-1,j:j+k-1)=S;
       immask(i:i+k-1,j:j+k-1)=Mask;
         
        
    end
end



end