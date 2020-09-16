function [lMeanTurnsBetweenHVandLV] = calcLMeanTurnsHVandLV(d,Dout)
dCM = d .* 100;
lMeanTurnsBetweenHVandLVCm = (3.14 .* (dCM+2+Dout) ) ./ 2 ;
lMeanTurnsBetweenHVandLV = lMeanTurnsBetweenHVandLVCm ./ 100;
end

