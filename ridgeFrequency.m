%{
input--> orientim= orientation image of fingerprint
         im= normalised image
output--> z= frequency image

%}

function [z]=ridgeFrequency(orientim,im)


[rows columns]=size(orientim);
k=32;
wavelength1=3;
wavelength2=25;
freq=zeros(rows,columns);
xi=1;
yj=1;
for i=1:k:rows-k
    for j=1:k:columns-k
        block=orientim(i:i+k-1,j:j+k-1);
       
        
        block1=im(i:i+k-1,j:j+k-1);
        block=2*block(:);
        cosblock=mean(cos(block));
        sinblock=mean(sin(block));
        orient=atan2(sinblock,cosblock)/2;
        rotim=imrotate(block1,orient/pi*180+90,'bilinear','crop');
        
        proj=mean(rotim);
        disp(proj);
        
         dilation = ordfilt2(proj, 5, ones(1,5));
    maxpts = (dilation == proj) & (proj > mean(proj));
    maxind = find(maxpts);
    
	NoOfPeaks = length(maxind);
   
        [m2 n2]=size(maxind);
        if length(maxind)>2
           ridge_length=(maxind(end)-maxind(1))/(NoOfPeaks-1);
          if ridge_length>wavelength1 && ridge_length<wavelength2
              freq(i:i+k-1,j:j+k-1)=1/ridge_length;
          else
              
            freq(i:i+k-1,j:j+k-1)=-1;
            x_i(xi)=i;
            xi=xi+1;
            y_j(yj)=j;
            yj=yj+1;
          end
          
         
        else
            freq(i:i+k-1,j:j+k-1)=-1;
            x_i(xi)=i;
            xi=xi+1;
            y_j(yj)=j;
            yj=yj+1;
        end
       
   end
        
         
end
z=freq;

[x y]=meshgrid(1:rows);

for i=1:k:rows-k
    for j=1:k:columns-k
        if z(i,j)==-1 
            
            Zi1=interp2(x,y,z,i,j,'cubic');
            
         
            Zi2=interp2(x,y,z,i+k,j,'cubic');
            
            Zi3=interp2(x,y,z,i,j+k,'cubic');
            
            Zi4=interp2(x,y,z,i+k,j+k,'cubic');
          
            Zi=(1/4)*(Zi1+Zi4+Zi2+Zi3);
            
            
            z(i:i+k-1,j:j+k-1)=Zi;
      
            
        end 
    end
end
imshow(z);




end
