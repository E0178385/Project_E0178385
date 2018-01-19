function p=poisson_prob(L,i)
  m=L(i);
  start=0;
  p=1;
  for i=1:length(L)
    if L(i)~= m
      p=p*poisson(m,start,L(i)-1);
    end
  end;
end