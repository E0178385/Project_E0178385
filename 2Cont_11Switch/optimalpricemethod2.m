function [V1,V2,price,loop_number,price1_pass,price2_pass,rew1_pass,rew2_pass]=optimalpricemethod2(load_passed,states,discount)
loop=2;
load=load_passed;
state_count=2^11;
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
price=[1;1];
present_state=2;  % initial state
previous_state=2;
P=zeros(2^11,2^11);
V1=zeros(1000,2^11);
V2=zeros(1000,2^11);
cc=zeros(1000,2^11);
dd=zeros(1000,2^11);
price1_pass=price(1);
price2_pass=price(2);   
loop_number=0;
rew1_pass=0;
rew2_pass=0;
for i=1:2^11,
        state=states(i,:);
        P(i,:)=calc_prob(state,price,states,load);
end;
disp(P);
while(loop<1000)
    disp('loop number');
    disp(loop);
            
    [~,b]=max(P(present_state,2:state_count-1));
    next_state=b+1;
            
    for j=1:state_count,
        state=states(j,:);
        r1=sum((state==1).*load')*price(1);
        r2=sum((state==2).*load')*price(2);
        V1(loop,j)=r1+(discount)*sum(P(:,j)'.*V1(loop-1,:));  %discount factor
        V2(loop,j)=r2+(discount)*sum(P(:,j)'.*V2(loop-1,:));
     end;
     
     cc(loop,:)=((V1(loop,:)-V1(loop-1,:))./(1+V1(loop,:)));
     dd(loop,:)=((V2(loop,:)-V2(loop-1,:))./(1+V2(loop,:)));
        if (cc(loop,present_state)<=0.01) 
            if (dd(loop,present_state)<=0.01)
            loop_number=loop;
            break;
            end;
        end; 
     
          
     diff_V1=sum((states(present_state,:)==1).*load')-sum((states(previous_state,:)==1).*load');
     diff_V2=sum((states(present_state,:)==2).*load')-sum((states(previous_state,:)==2).*load');
     
     price(1)=price(1)+(price(1)*(diff_V1/sum(load)));
     price(2)=price(2)+(price(2)*(diff_V2/sum(load)));
     price1_pass=[price1_pass price(1)];
     price2_pass=[price2_pass price(2)];
     rew1_pass=[rew1_pass V1(loop,present_state)];
     rew2_pass=[rew2_pass V2(loop,present_state)];
    previous_state=present_state;
    present_state=next_state; 
    loop=loop+1;
end;
end
