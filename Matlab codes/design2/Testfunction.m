
% testing with pre determined price - 91% accuracy
clc
iter=1000;
load=[10 30 20]';
[V1,V2,price,loop_num,price1,price2]=optimalpricemethod1(load);
states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
disp('Optimal Price is:');
disp(price);
load=[10 30 20]';
[V1,V2,loop_num]=rewardwithfixedprice(price,load);
[~,temp]=max(V1(loop_num,2:7));
state_trial=temp+1;
state_trial_sym=symmetric_state(temp);
disp('State with optimal price and average load:');
disp(state_trial);
input('Press enter to run test');
V1_arr=zeros(iter,8);
V2_arr=zeros(iter,8);
state=zeros(iter,1);
res_time1=zeros(iter,1);
res_time2=zeros(iter,1);
for i=1:iter
    load=[poissrnd(10) poissrnd(30) poissrnd(20)]';
    [V1,V2,loop_num]=rewardwithfixedprice(price,load);
    V1_arr(i,:)=V1(loop_num,:);
    V2_arr(i,:)=V2(loop_num,:);
    [~,b]=max(V1(loop_num,2:7));
    state(i)=b+1;
    Load_1=sum((states(state(i),:)==1).*load');
    Load_2=sum((states(state(i),:)==2).*load');
    res_time1(i)=100/(100-Load_1);   % milliseconds
    res_time2(i)=100/(100-Load_2);
end;
disp('Percentage of correct prediction');
disp(100*(sum(state==state_trial)+sum(state_trial_sym))/iter);
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
axis([1 100 1 8]);
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
