function [Xeq] =  calcXeq(frequency,coilLength,lMeanTurnsBetweenHVandLV,lvcondWidth,hvcondDiameter,duct,hvsNoTurns)
b1 = lvcondWidth ./ 100;
b2 = (10 .* hvcondDiameter) ./100 ;
a  = (duct + 1) ./ 100;
z = a + ( (b1 +b2) ./ 3 );
turnsSquared = power(hvsNoTurns,2);
permability = 4 .* 3.14 .* power(10,-7);
Xeq = 2 .* 3.14 .* frequency .* permability .* turnsSquared .* z .* (lMeanTurnsBetweenHVandLV ./ coilLength);
end

