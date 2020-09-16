function [LMeanTurns] = caclLMeanTurns(d,FormerWidth)    
LMeanTurnsCM = (3.14 .* ( (d+2) +  FormerWidth) ) ./ 2;
LMeanTurns = LMeanTurnsCM ./ 100; 
end

