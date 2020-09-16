function [condWidth,condHeight,condDiameter] = calcConductorDimensions(CSA , shape)
    if strcmp(shape,"square") == 1 
        condWidth    =  ((sqrt(CSA)) + 2) ./ 10;
        condHeight   =  ((sqrt(CSA)) + 2) ./ 10;
        condDiameter =  0;
    else
        condDiameter = (sqrt( (4 .* CSA) ./ 3.14  ) +2 ) ./ 10   ;
        condWidth  = 0;
        condHeight = 0; 
    end
end

