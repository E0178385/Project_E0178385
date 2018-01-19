function [K,N,mu]=getdata()
  K=input('Enter number of switches \n');
  N=input('Enter number of controllers \n');
  %lambda=zeros(K,1);
  mu=zeros(N,1);
  %{
for i =1:K,
   # printf("Enter value of lambda for switch %d \n ", i);
    #lambda(i)=input("");
  #end;
  %}
  temp=input('Enter value of Mu for controllers \n ');
  for i=1:N
    mu(i)=temp;
  end
end