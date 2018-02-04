function [ state ] = state_deter( L1_state,L2_state, states)
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
temp_state=L1_state+(L2_state.*2);
for i=1:2^11,
    if sum(states(i,:)==temp_state)==11,
        state=i;
    end;
end;


end

