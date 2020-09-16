function [tankShape,ThetaRiseMax,Ntupes,Stube] = DesignTankShape(x,y,z,maxAllowableTempRise,pi,hvsCurrent,Req)
dt = 0.05;
It = 0.075;
TankDissipationArea = (2 .* x .* z)+(2 .* y .* z)+(x .* y ./ 2);
Pcu = 3 .* power(hvsCurrent,2) .* Req;
ThetaRiseMax = (pi + Pcu) / (12.5 .* TankDissipationArea);
if  ThetaRiseMax <= maxAllowableTempRise
    tankShape =  "Plain Walled Tank";
    Ntupes =0;
    Stube =0;
else
    ThetaRiseMax = maxAllowableTempRise ;
    Stube =( ( (pi + Pcu)  / maxAllowableTempRise) - (12.5 .* TankDissipationArea) ) / 8.8 ;
    Ntupes = (Stube) / (3.14 .* dt .* z);
    requiredPerimeter = Ntupes * (dt + It);
    condition = 2 * (x+y);
    if requiredPerimeter > condition
        tankShape = "2 Layer tubes ";
    else
        tankShape = "single layer tubes ";
    end
end

end

