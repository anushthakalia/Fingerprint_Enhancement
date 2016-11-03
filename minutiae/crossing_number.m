
%Implementation of crossing number method to find the minutiae points
%input-->Thinned image
%output-->minutiae points matrix



function [M,M1]= crossing_number(I)


[m n]=size(I);
M=size(m,n);
M1=size(m,n);


for i=2:m-1
    for j=2:n-1
      sum1=0;
        for i1=i-1:i+1
            for j1=j-1:j+1
                if i1==i && j1==j
                    continue;
                end
                if i1==i-1 && j1==j-1  
                sum1= sum1+ abs(I(i1,j1)-I(i1+1,j1))+ abs(I(i1,j1)-I(i1,j1+1));
                
                elseif i1==i-1 && j1==j+1
                sum1= sum1+ abs(I(i1,j1)-I(i1+1,j1))+ abs(I(i1,j1)-I(i1,j1-1));   
                elseif i1==i+1 && j1==j-1
                 sum1= sum1+ abs(I(i1,j1)-I(i1-1,j1))+ abs(I(i1,j1)-I(i1,j1+1));  
                elseif i1==i+1 && j1==j+1 
               sum1= sum1+ abs(I(i1,j1)-I(i1-1,j1))+ abs(I(i1,j1)-I(i1,j1-1));
                end
                
              end
        end
                
                
        M(i,j)=0.5*sum1;
        if I(i,j)==0
            M1(i,j)=M(i,j);
        end
        
            
        
        
    end
end




end
