%{
  This function returns the orientation image of im
  input--> im: normalised image
  output-->o: orientation image
  I have used sobel operator to generate gradient magnitudes
  implementation of pixel based method for orientation image
  

%}
    
function o = ridgeOrientation(im)
    [m n]=size(im);

    h=fspecial('sobel');
    Gy=filter2(h,im);  % Gradient magnitudes along the y direction
    Gx=filter2(transpose(h),im); % Gradient magnitudes along the x direction

    dev_st=3; % standard deviation
    dim = fix(6*dev_st); 
    
    Gxx = Gx.^2;      
    Gxy = Gx.*Gy;
    Gyy = Gy.^2;       
    f = fspecial('gaussian', dim,dev_st);
    Gxx = filter2(f, Gxx); 
    Gxy = 2*filter2(f, Gxy);
    Gyy = filter2(f, Gyy);
    
    
    
   
    denom = sqrt(Gxy.^2 + (Gxx - Gyy).^2) + eps;
    sin2theta = Gxy./denom;            
    cos2theta = (Gxx-Gyy)./denom;

    
    N = pi/2 + atan2(sin2theta,cos2theta)/2;
    
     phi_x=cos(2*N);
     phi_y=sin(2*N);
              
     h = fspecial('gaussian',dim, dev_st);% for smoothing orientation image
          
     new_phix=imfilter(phi_x,h,'conv');
         
     new_phiy=imfilter(phi_y,h,'conv');
     
     o=0.5*atan2(new_phiy,new_phix);% o is the final orientation image
       
   
end
