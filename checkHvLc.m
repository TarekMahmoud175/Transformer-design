function [checkHVlc] = checkHvLc(hvFormerHeight,twoC,Hw)
   totalHeightCompared = hvFormerHeight + twoC;
   if totalHeightCompared  < Hw 
       checkHVlc = "height of Hv coil is accepted";
   else 
       checkHVlc = "height of Hv coil needs Re-design";
   end
end

