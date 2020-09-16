function [Aw] = CalcAreaWindow(s,ai,bm,delta,kw,frequency)

    Aw = (s .* power(10,3)) ./ (3.33 .* ai .* bm .* kw .* delta .* frequency);
end

