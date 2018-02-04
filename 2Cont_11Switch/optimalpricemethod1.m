function [V1,V2,price,loop_number,price1_pass,price2_pass]=optimalpricemethod1(load_passed,states,discount)
    loop=2;
    load=load_passed;
    state_count=2^11;
    %states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
    price=[1;0.5];
    P=zeros(2^11,2^11);
    V1=zeros(1000,2^11);
    V2=zeros(1000,2^11);
    cc=zeros(1000,2^11);
    dd=zeros(1000,2^11);
    price1_pass=price(1);
    price2_pass=price(2);   
  
    for i=1:2^11
        state=states(i,:);
        P(i,:)=calc_prob(state,price,states,load);
    end;
    disp(P)
    V1(1,:)=zeros(1,2^11);
    V2(1,:)=zeros(1,2^11);
    loop_number=0;
    diff_V1=zeros(1,1000);
    diff_V2=zeros(1,1000);
    for i=1:2^11
            state=states(i,:);
            P(i,:)=calc_prob(state,price,states,load);
    end;   
    
    while(loop<=1000)
        disp('loop number');
        disp(loop);
        for j=1:2^11
            
             
            state=states(j,:);
            r1=sum((state==1).*load')*price(1);
            r2=sum((state==2).*load')*price(2);
            V1(loop,j)=r1+(discount)*sum(P(:,j)'.*V1(loop-1,:));
            V2(loop,j)=r2+(discount)*sum(P(:,j)'.*V2(loop-1,:));
        end;
        cc(loop,:)=((V1(loop,:)-V1(loop-1,:))./(1+V1(loop,:)));
        dd(loop,:)=((V2(loop,:)-V2(loop-1,:))./(1+V2(loop,:)));
        if (cc(loop,:)<=0.01) 
            if (dd(loop,:)<=0.01)
            loop_number=loop;
            break;
            end;
        end; 
        diff_V1(loop)=max(V1(loop,2:state_count-1)-V1(loop-1,2:(2^11)-1));
        diff_V2(loop)=max(V2(loop,2:state_count-1)-V2(loop-1,2:(2^11)-1));
        if(loop==2)
            diff_V1(2)=max(V1(2,2:(2^11)-1));
            diff_V2(2)=max(V2(2,2:(2^11)-1));
        end;
        price(1)=price(1)+(price(1)*((diff_V1(loop)-diff_V1(loop-1))*.05/diff_V1(loop)));
        %disp(price(1))
        price(2)=price(2)+(price(2)*((diff_V2(loop)-diff_V2(loop-1))*.05/diff_V2(loop)));
        %disp(price(2));
        price1_pass=[price1_pass price(1)];
        price2_pass=[price2_pass price(2)];
        for k=1:2
            if price(k)<0.1
                price(k)=0.1;
            end;
            if price(k)>2
                price(k)=2;
            end;
        end;

        loop=loop+1;
    end;
end
