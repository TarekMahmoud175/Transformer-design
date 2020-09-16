function [x,y,z] = calcTankDimensions(Dout,Width,Height,a,hv)
  Doutm = Dout ./ 100;    
   if hv <= 66
        D =0.12;
    else
        D=0.32;
    end
    x= Doutm + (2*D);
    y= Width + Doutm + (2*D) - a;
    z= Height  + 0.5;
end

