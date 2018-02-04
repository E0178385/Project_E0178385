function state=check_sym(load_normal,load_present,state_normal,state_present)
if ( abs(load_normal(1)-load_present(1)) <= 5 || (load_normal(1)-load_present(1))/load_normal(1) < 0.15 ),
    if ( abs(load_normal(2)-load_present(2)) <= 5 || (load_normal(2)-load_present(2))/load_normal(2) < 0.15 ),
        state=state_normal;
    else
        state=state_present;
    end;
else
    state=state_present;
end;

   
    
