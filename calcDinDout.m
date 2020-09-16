function [Din,Dout]= calcDinDout(duct ,hvFormerWidth,lvFormerWidth)
    Din     = lvFormerWidth + (2 .* duct);
    Dout    = Din + (2 .* hvFormerWidth);
end

