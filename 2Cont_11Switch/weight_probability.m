function q=weight_probability(p,states)
  q=zeros(1,size(states,1));
  for i=1:size(states,1)
    state=states(i,:);
    q1=zeros(size(p,1),1);
    for j=1:size(p,1)
      q1(j)= sum(p(j,:).*(state==j))+sum((1-p(j,:)).*(1-(state==j)));
    end
    q(i)=prod(q1);
  end
end