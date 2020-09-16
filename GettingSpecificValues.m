function [delta ,Bm] = GettingSpecificValues()
%check wether user want to add values or no
    AddSpecific = input('do you want to add cuurrent density , magnetic field density ? \n','s');
    if strcmp(AddSpecific,'yes') == 1 
        %check on current density
        condition1 =input('have value of current density? \n' , 's');
        if strcmp(condition1 , 'yes') ==1
            CD = input('enter current density \n' );
            delta = CD .* power(10,6);
        else
            delta = 2.3.*power(10,6);
        end

        %check on magnetic field density 
        condition2 =input('have value of magnetic field density? \n' , 's');
        if strcmp(condition2 , 'yes') ==1
            Bm = input('enter magnetic field density  \n');
        else
            Bm = 1.3;
        end

    else
         %assumed hot rolled and the value could be for power or dist transformer
         Bm = 1.3;
         delta = 2.3.*power(10,6);
    end
end

