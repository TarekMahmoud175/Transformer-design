function [turns] = calcNoTurns(connection,E_turn,voltage)
    if strcmp(connection,"star") == 1
       turns = ceil((voltage.* power(10,3) ./ sqrt(3)) ./ E_turn) ;
    else
       turns = ceil((voltage .* power(10,3)) ./ E_turn );
    end
end

