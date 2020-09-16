function [coilLength] = calcCoilLength(hvFormerHeight,lvFormerHeight)
  coilLengthCM = (hvFormerHeight + lvFormerHeight) ./ 2;
  coilLength = coilLengthCM ./ 100;
end

