function p=exp_prob(L,i,price,mu)
  m=L(i);
  start=0;
  lambda=1./(mu-L);
  %disp(lambda);
  denom=sum((price(i)./price).*lambda);
  p=lambda(i)/denom;
end