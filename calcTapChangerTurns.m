function  [tapChangerTurns]= calcTapChangerTurns(hvsNoTurns,offLoadTapChangerPercentage)
    tapChangerTurns= (offLoadTapChangerPercentage ./ 100) .*  hvsNoTurns;
end

