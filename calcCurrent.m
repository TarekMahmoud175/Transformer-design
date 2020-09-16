function [I] = calcCurrent(connection,powerRating,voltage)
    
  if strcmp(connection,"star")==1
    I = powerRating  ./ ( sqrt(3) .* voltage );
  else
    I = (powerRating) ./ (3 .* voltage );
  end
end

