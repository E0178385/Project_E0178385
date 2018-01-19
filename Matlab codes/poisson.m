function p=poisson(mean,start,stop)
  p1=zeros(stop-start+1,1);
  j=1;
  for i=start:stop
    p1(j,1)=(exp(-mean)*power(mean,i))/(factorial(i));
    j=j+1;
  end
  p=sum(p1);
end