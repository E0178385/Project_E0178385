function p=choice_probability(lambda,state,N,price,mu)
  p=zeros(N,size(lambda,1));
  for i=1:size(lambda,1)
    L=zeros(N,1);
    for j=1:N
        if sum(i==find(state==j))>0
            L(j)=sum(lambda(state==j));
        else
            L(j)=sum(lambda(state==j))+lambda(i);
        end
    end
    for j=1:N
      p(j,i)=exp_prob(L,j,price,mu);
      %disp(L);
    end
  end
  
  end
