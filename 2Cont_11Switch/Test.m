clc;
clear all;
iter=100;
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
states=States_generate();
initial_state=2;
pres_state=initial_state;
present_state=zeros(1,iter);
C1=300;
C2=300;
Load1=zeros(1,iter);
Load2=zeros(1,iter);
for i=1:iter,
    present_state(i)=pres_state;
    Load=[poissrnd(10) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20)];
    thresh=sum(Load)/11;
    L1_state=(states(pres_state,:)==1);
    L2_state=(states(pres_state,:)==2);
    L1=L1_state.*Load;
    L2=L2_state.*Load;
    Load1(i)=sum(L1);
    Load2(i)=sum(L2);
    res_time1(i)=300/(300-Load1(i));   % milliseconds
    res_time2(i)=300/(300-Load2(i));
    ishot1=(sum(L1)>=thresh);
    ishot2=(sum(L2)>=thresh);
    if ishot1==1 && ishot2==1 && (sum(L1)> sum(L2)),
        ishot2=0;
    end;
    if ishot1==1 && ishot2==1 && (sum(L2) > sum(L1)),
        ishot1=0;
    end;
    Sw_C1=states(pres_state,:)==1;
    Sw_C2=states(pres_state,:)==2;
    if ishot1==1,
       [max_val,max_position]= max(L1);
       if sum(L2)+max_val >= C2,
           continue;
       end;
       L1_state(max_position)=0;
       L2_state(max_position)=1;
    end;
    if ishot2==1,
       [max_val,max_position]= max(L2);
       if sum(L1)+max_val >= C1,
           continue;
       end;
       L2_state(max_position)=0;
       L1_state(max_position)=1;
    end;
    pres_state=state_deter(L1_state,L2_state,states);
end;
    
    