function [a,b,c,d,e] = calcDimensions(ai,num)
if num == 2
    d= sqrt(ai ./ 0.56)  ;
    a= 0.85 .* d ;
    c= 0.53 .* d ;
    b= c + (2 .* 0.16 .* d) ;
    e = 0; 
elseif num == 3 
    d= sqrt(ai ./ 0.6) ;
    a = 0.9  .* d ; 
    e = 0.42 .* d ;
    c = e + (2 .* 0.14 .* d);
    b = c + (2 .* 0.1 .* d) ;
end
end

