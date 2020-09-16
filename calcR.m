function [R]= calcR(NoTurns,LMeanTurns,CSA)
 R  = (0.021 .* NoTurns .* LMeanTurns ) ./ CSA;
end

