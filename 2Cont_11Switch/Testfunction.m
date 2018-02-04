
% testing with pre determined price - 91% accuracy
clc
iter=10;
load=[10 30 20 30 20 30 20 30 20 30 20]';
states=States_generate();
state_count=2^11;
[V1,V2,price,loop_num,price1,price2]=optimalpricemethod2(load,states,0.85);
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
disp('Optimal Price is:');
disp(price);
%load=[10 30 20 10 30 ]';

[V1,V2,loop_num]=rewardwithfixedprice(price,load,states);
[~,temp]=max(V1(loop_num,2:state_count-1));
state_trial=temp+1;
state_trial_sym=symmetric_state(state_trial);
Load_C1_normal=sum((states(state_trial,:)==1).*load');
Load_C2_normal=sum((states(state_trial,:)==2).*load');
disp('State with optimal price and average load:');
disp(state_trial);
input('Press enter to run test');
V1_arr=zeros(iter,state_count);
V2_arr=zeros(iter,state_count);
state=zeros(iter,1);
res_time1=zeros(iter,1);
res_time2=zeros(iter,1);
for i=1:iter
    disp('iteration number')
    disp(i);
    load=[poissrnd(10) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) poissrnd(30) poissrnd(20) ]';
    [V1,V2,loop_num]=rewardwithfixedprice(price,load,states);
    V1_arr(i,:)=V1(loop_num,:);
    V2_arr(i,:)=V2(loop_num,:);
    [~,b]=max(V1(loop_num,2:31));
    state(i)=b+1;
    Load_1_prior=sum((states(state(i),:)==1).*load');
    Load_2_prior=sum((states(state(i),:)==2).*load');
    if i>1,
    state(i)=check_sym([Load_C1_normal Load_C2_normal],[Load_1_prior Load_2_prior], state_trial, state(i));
    end;
    Load_1=sum((states(state(i),:)==1).*load');
    Load_2=sum((states(state(i),:)==2).*load');
    res_time1(i)=300/(300-Load_1);   % milliseconds
    res_time2(i)=300/(300-Load_2);
end;



disp('Percentage of correct prediction');
disp(100*(sum(state==state_trial)+sum(state==state_trial_sym))/iter);
%{
figure(1);
plot(1:length(price1),price1);
xlim([0 20]);
xlabel('iteration');
ylabel('price');
hold on;
plot(1:length(price2),price2);
xlim([0 20]);
xlabel('iteration');
ylabel('price');
hold off;
legend('controller 1','controller2');
figure(2);
plot(1:100,state(1:100),'o');
axis([1 100 1 32]);
xlabel('iterations');
ylabel('state');
figure(3);
subplot(2,1,1);
plot(1:length(price1),price1);
xlim([0 20]);
xlabel('iteration');
ylabel('price');
subplot(2,1,2);
plot(1:length(price2),price2);
xlim([0 20]);
xlabel('iteration');
ylabel('price');
figure(4);
title('response times comparison');
plot(1:100,res_time1(1:100));

hold on;
plot(1:100,res_time2(1:100));
xlabel('iteration');
ylabel('response times');
hold off;
legend('controller 1','controller2');




%{
 testing with pre determined price method 2- 96% accuracy
clc
iter=1000;
load=[10 30 20]';
[V1,V2,price,loop_num]=optimalpricemethod2(load);
V1_arr=zeros(iter,8);
V2_arr=zeros(iter,8);
state=zeros(iter,1);
for i=1:iter
    load=[poissrnd(10) poissrnd(30) poissrnd(20)]';
    [V1,V2,loop_num]=rewardwithfixedprice(price,load);
    V1_arr(i,:)=V1(loop_num,:);
    V2_arr(i,:)=V2(loop_num,:);
    [~,b]=max(V1(loop_num,2:7));
    state(i)=b+1;
end;
state
%}

% testing with change in price  -> 85 % accuracy
%{
clc
iter=100;
price_arr=zeros(iter,2);
V1_arr=zeros(iter,8);
V2_arr=zeros(iter,8);
state=zeros(iter,1);
for i=1:iter
    load=[poissrnd(10) poissrnd(30) poissrnd(20)]';
    [V1,V2,price,loop_num]=optimalpricemethod1(load);
    price_arr(i,:)=price;
    V1_arr(i,:)=V1(loop_num,:);
    V2_arr(i,:)=V2(loop_num,:);
    [~,b]=max(V1(loop_num,2:7));
    state(i)=b+1;
end;
%}
%}