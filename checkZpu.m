function [CheckZpu] =  checkZpu(Zeq,PowerRating,hv)
    Zbase = (PowerRating) /(3 * power(hv,2) );
    Zpu   =  Zeq/Zbase; 
    if  Zpu > 0.1
        CheckZpu = "Zeq needs Re-design";
    else
        CheckZpu = "Zeq is accepted";
    end
end

