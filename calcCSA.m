function [CSA, shape] = calcCSA(I,delta)
%CSA in mm^2
    CSA = I / (delta .* power(10,-6));
    if  CSA <= 10
        shape = "circle";
    else 
        shape = "square";
    end
end

