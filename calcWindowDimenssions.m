function [Ww , Hw] = calcWindowDimenssions(Aw)
    Ww = sqrt(Aw ./3 );
    Hw = 3 .* Ww ;
end

