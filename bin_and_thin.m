%{
This function performs binarization and thinning
input-->(enhanced image,mask)
output-->(final_image after fingerprint enhancement)
%}

function final_image=bin_and_thin(enhanced,mask)
[m n]=size(enhanced);
%binarization
J=size(m,n);
for i=1:m
    for j=1:n
        if enhanced(i,j)<=0
            J(i,j)=0;
        elseif enhanced(i,j)>0
            J(i,j)=1;
        end
        
    end
end
   J=J.*mask;
  figure(7);
  imshow(J);
%thinning  
final_image=bwmorph(~J,'thin','inf');%this function is used for thinning
figure(8);
imshow(~final_image);
set(gcf,'position',[1 1 300 300]);
end


