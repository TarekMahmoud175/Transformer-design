function [Kw] = windowConstant(hv,powerRating)
    
  if powerRating <= 50
      Kw = (8) ./ (30 + hv); 
  elseif powerRating <= 200 
      if powerRating > 50
          Kw = (10) ./ (30 + hv);
      end
  elseif powerRating <= 1000 
      if powerRating > 200
        Kw = (12) ./ (30 + hv);
      end
  end

end

