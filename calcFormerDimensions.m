function [formerWidth , formerHeight] = calcFormerDimensions(shape,d,condWidth,condHeight,condDiameter,tpcht,turns)

if strcmp(shape , "square") == 1
    formerWidth  = (d .* 100) + 2 + ( 2 .* condWidth);
    formerHeight = turns .* condHeight;
    %cond diameter should be added to parameters
    %tpcht is tap changer turns
else
    heightOneFormer    = (10 .* condDiameter) +2 ;
    totTurns = turns + tpcht;
    if totTurns < 1000
        numberOfHudred = floor(totTurns ./ 100);
        rest     = floor(rem(totTurns ./ 10,10));
    else
        numberOfHudred = floor(totTurns ./ 100);
        rest = floor(rem(totTurns ,100) ./ 10);
    end
    heightofrest = (rest .* condDiameter) +2;
    %calc the total height of formers
    totalLvh           = (numberOfHudred .* heightOneFormer) +heightofrest ;
    formerHeight       = totalLvh;
    %calc the former width
    formerWidth        = (10 .* condDiameter) + 1;
end
end