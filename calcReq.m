function [Req]= calcReq(Rlv,Rhv,lvsNoTurns,hvsNoTurns)
x   = hvsNoTurns ./ lvsNoTurns;
Req = Rhv + (Rlv .* power(x,2) );
end

