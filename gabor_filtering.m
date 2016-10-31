%{
gabor filter
input-->(normalised image,frequency image,orientation image)
output-->(enhanced image)
reference- Peter Kowasi's matlab functions

%}

function enhanced=gabor(im,freq,orient)
 
     kx=0.5;
     ky=0.5;
    % angle increment for orientations from 0 to 180
    angleInc = 3;
    
    im = double(im);
    
    [rows, cols] = size(im);
    enhanced = zeros(rows,cols);
    
    [valid_rows,valid_columns] = find(freq > 0);  
    
    ind = sub2ind([rows,cols], valid_rows, valid_columns);
    
    
    freq(ind) = round(freq(ind)*100)/100;
    
    
    unique_freq = unique(freq(ind));%finding the unique frequencies 
    
    
    
    filter = cell(length(unique_freq),180/angleInc);
    
    
    filter_size = zeros(length(unique_freq),1);
    
    for k = 1:length(unique_freq)
        sigmax =1/unique_freq(k)*kx;
        sigmay =1/unique_freq(k)*ky;
        
        filter_size(k) = round(3*max(sigmax,sigmay)); 
        
        [x,y] = meshgrid(-filter_size(k):filter_size(k));
        %this is the gabor filter
        gb = exp(-(x.^2/sigmax^2 + y.^2/sigmay^2)/2).*cos(2*pi*unique_freq(k)*x);

      
        for o = 1:180/angleInc
            filter{k,o} = imrotate(gb,-(o*angleInc+90)); 
        end
    end
    %removes the boundary points
    maxsize = filter_size(1);   
    disp(maxsize);
    finalind = find(valid_rows>maxsize & valid_rows<rows-maxsize & valid_columns>maxsize & valid_columns<cols-maxsize);
    disp(size(finalind));
   
    % converting the orientation matrix and reducing the range from 0 to 60
    maxorientindex = round(180/angleInc); 
    orientindex = round(orient/pi*180/angleInc);
    i = find(orientindex < 1); 
    disp(size(i));
    %to make sure taht all orientations between 0 and 60
    orientindex(i) = orientindex(i)+maxorientindex;
    disp(orientindex);
    
    % Finally do the filtering
    for k = 1:length(finalind)
        r = valid_rows(finalind(k));
        c = valid_columns(finalind(k));
       % filter corresponding to freq(r,c)
       a=round(freq(r,c)*100)/100;
      
        filterindex=find(unique_freq==a);
       
        disp(filterindex);
        s = filter_size(filterindex);   
        enhanced(r,c) = sum(sum(im(r-s:r+s, c-s:c+s).*filter{filterindex,orientindex(r,c)}));
    end
   imshow(enhanced);
end
