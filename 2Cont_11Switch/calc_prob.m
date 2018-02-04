function P=calc_prob(state,price,states,load)
N=2;
mu=100;
p=choice_probability(load,state,N,price,mu);
q=weight_probability(p,states);
P=transition_probability(q);
end

