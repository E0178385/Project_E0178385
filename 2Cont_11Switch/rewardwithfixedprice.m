function [V1,V2,loop_number]=rewardwithfixedprice(price_input,input_load,states)
state_count=2^11;
loop=2;
load=input_load;
%states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
price=price_input;  %[0.5;0.5] format
P=zeros(2^11,2^11);
V1=zeros(1000,state_count);
V2=zeros(1000,state_count);
for i=1:state_count,
    state=states(i,:);
    P(i,:)=calc_prob(state,price,states,load);
end;
%disp(P)
loop_number=0;
while(loop<=1000)
    for j=1:state_count,
        state=states(j,:);
        r1=sum((state==1).*load')*price(1);
        r2=sum((state==2).*load')*price(2);
        V1(loop,j)=r1+sum(P(:,j)'.*V1(loop-1,:));
        V2(loop,j)=r2+sum(P(:,j)'.*V2(loop-1,:));
    end;
    cc(loop,:)=((V1(loop,:)-V1(loop-1,:))./(1+V1(loop,:)));
    dd(loop,:)=((V2(loop,:)-V2(loop-1,:))./(1+V2(loop,:)));
    if (cc(loop,:)<=0.01) 
        if (dd(loop,:)<=0.01)
        loop_number=loop;
        break;
        end;
    end; 
    loop=loop+1;
        
end;
end