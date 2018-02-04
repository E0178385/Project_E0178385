clc
iter=100;
load=[10 30 20 30 20 30 20 30 20 30 20]';
states=States_generate();
state_count=2^11;
[V1,V2,price_method1,loop_num,price1,price2]=optimalpricemethod2(load,states,0.85);
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
disp('Optimal Price is:');
disp(price_method1);
%load=[10 30 20 10 30 ]';

[V1,V2,loop_num]=rewardwithfixedprice(price_method1,load,states);
[~,temp]=max(V1(loop_num,2:state_count-1));
state_trial=temp+1;
state_trial_sym=symmetric_state(state_trial);
Load_C1_normal=sum((states(state_trial,:)==1).*load');
Load_C2_normal=sum((states(state_trial,:)==2).*load');
disp('State with optimal price and average load:');
disp(state_trial);
%input('Press enter to run test');
V1_arr=zeros(iter,state_count);
V2_arr=zeros(iter,state_count);
state_method1=zeros(iter,1);
res_time1_method1=zeros(iter,1);
res_time2_method1=zeros(iter,1);
for i=1:iter
    disp('iteration number')
    disp(i);
    load=[poissrnd(10) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) ]';
    [V1,V2,loop_num]=rewardwithfixedprice(price_method1,load,states);
    V1_arr(i,:)=V1(loop_num,:);
    V2_arr(i,:)=V2(loop_num,:);
    [~,b]=max(V1(loop_num,2:31));
    state_method1(i)=b+1;
    Load_1_prior=sum((states(state_method1(i),:)==1).*load');
    Load_2_prior=sum((states(state_method1(i),:)==2).*load');
    if i>1,
    state_method1(i)=check_sym([Load_C1_normal Load_C2_normal],[Load_1_prior Load_2_prior], state_trial, state_method1(i));
    end;
    Load_1=sum((states(state_method1(i),:)==1).*load');
    Load_2=sum((states(state_method1(i),:)==2).*load');
    res_time1_method1(i)=300/(300-Load_1);   % milliseconds
    res_time2_method1(i)=300/(300-Load_2);
end;
disp('Percentage of correct prediction');
disp(100*(sum(state_method1==state_trial)+sum(state_method1==state_trial_sym))/iter);


% method 2

[V1,V2,price_method2,loop_num,price1,price2]=optimalpricemethod2(load,states,1);
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
disp('Optimal Price is:');
disp(price_method2);
%load=[10 30 20 10 30 ]';

[V1,V2,loop_num]=rewardwithfixedprice(price_method2,load,states);
[~,temp]=max(V1(loop_num,2:state_count-1));
state_trial=temp+1;
state_trial_sym=symmetric_state(state_trial);
Load_C1_normal=sum((states(state_trial,:)==1).*load');
Load_C2_normal=sum((states(state_trial,:)==2).*load');
disp('State with optimal price and average load:');
disp(state_trial);
%input('Press enter to run test');
V1_arr=zeros(iter,state_count);
V2_arr=zeros(iter,state_count);
state_method2=zeros(iter,1);
res_time1_method2=zeros(iter,1);
res_time2_method2=zeros(iter,1);
for i=1:iter
    disp('iteration number')
    disp(i);
    load=[poissrnd(10) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) ]';
    [V1,V2,loop_num]=rewardwithfixedprice(price_method2,load,states);
    V1_arr(i,:)=V1(loop_num,:);
    V2_arr(i,:)=V2(loop_num,:);
    [~,b]=max(V1(loop_num,2:31));
    state_method2(i)=b+1;
    Load_1_prior=sum((states(state_method2(i),:)==1).*load');
    Load_2_prior=sum((states(state_method2(i),:)==2).*load');
    if i>1,
    state_method2(i)=check_sym([Load_C1_normal Load_C2_normal],[Load_1_prior Load_2_prior], state_trial, state_method1(i));
    end;
    Load_1=sum((states(state_method2(i),:)==1).*load');
    Load_2=sum((states(state_method2(i),:)==2).*load');
    res_time1_method2(i)=300/(300-Load_1);   % milliseconds
    res_time2_method2(i)=300/(300-Load_2);
end;
disp('Percentage of correct prediction');
disp(100*(sum(state_method2==state_trial)+sum(state_method2==state_trial_sym))/iter);

%old method

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
    

