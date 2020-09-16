function [Zeq] =  calcZeq(Xeq,Req)
Zeq = sqrt( power(Xeq,2) + power(Req,2) ) ;
end

