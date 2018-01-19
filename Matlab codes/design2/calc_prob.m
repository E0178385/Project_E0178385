function P=calc_prob(state,price,states,l)
N=2;
mu=100;
p=choice_probability(l,state,N,price,mu);
q=weight_probability(p,states);
P=transition_probability(q);
end

