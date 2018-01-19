function P1=transition_probability(q)
  for i=1:size(q,1)
    P1(i,:)=q(i,:)/sum(q(i,:));
  end
end