function p=exp_prob(L,i,price,mu)
  m=L(i);
  lambda=(mu-L);
  %disp(lambda);
  denom=sum((price(i)./price).*lambda);
  p=lambda(i)/denom;
end