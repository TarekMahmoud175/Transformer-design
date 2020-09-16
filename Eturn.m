function [E_turn] = Eturn(S)

    %checking value of k and getting  E_Turn
    answer = input('Do you have Constant K? \n','s');
    condition =  strcmp(answer,"yes");
    if condition == 1 
        %enter value of K
        K = input('Enter Value of k \n');
        E_turn = K .* sqrt(S);
    else
        %enter value of E_turn
        E_turn = input('Enter Value of E per turn \n');
    end
end

