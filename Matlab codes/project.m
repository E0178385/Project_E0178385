clc;
clear all;
samplesize=1000;
[K,N,mu]=getdata();
states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
price_initial=[[.8,0.2]; [0.6,0.4];[0.5,0.5];[0.7,0.3]; [0.3, 0.7];[0.5 0.5];[0.4,0.6];[0.2,0.8]];
control=1;%input('Enter 1 for P at mean or else 2;');
if control==1
  p=zeros(N,K);
  for i=1:size(states,1)
    present_state=states(i,:);
    price_ini=price_initial(i,:);
    l=[10 30 20]';
    p=choice_probability(l,present_state,N,price_ini',mu);
    %p=choice_probability(l,present_state,N,[0.5;0.5],mu);
    q(i,:)=weight_probability(p,states);
    P=transition_probability(q);
    
  end
  
save myfile1.mat P 
else
  nextstates=zeros(samplesize,8);
  L=[0 0 0 ];
  A=zeros(8,8,samplesize);
  for j=1:samplesize
    l1=poissrnd(10);
    l2=poissrnd(30);
    l3=poissrnd(20);
    
    for i=1:size(states,1)
    p=zeros(N,K);
    present_state=states(i,:);
    lambda=[l1 l2 l3]';
    p=choice_probability(lambda,present_state,N);
    q(i,:)=weight_probability(p,states);
    P=transition_probability(q);
    end
    %disp("iter number"), disp(j);
    %disp(lambda);
    A(:,:,j)=P;
    %{
    L=[L;l1 l2 l3];
    if abs(l1+l3-l2)<=5,
      sum=sum+1;
    elseif abs(l1+l3-l2)<=7,
      sum1=sum1+1;
    elseif abs(l1+l3-l2)<=10,
      sum2=sum2+1;
    end;
    %}
    nextstates(j,:)=game(P)';
    
  end
  
  save myfile.mat A;
  analysis(nextstates,8);
end



