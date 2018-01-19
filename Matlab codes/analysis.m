function analysis(nextstates,states)
  count=zeros(states,1);
  for i=1:states
    count(i,1)=size(find(nextstates==i),1);
  end
disp('number of times move to state 1 or 8:');
disp(count(1)+count(8));
disp('number of times move to state 2 or 7:');
disp(count(2)+count(7));
disp('number of times move to state 3 or 6:');
disp(count(3)+count(6));
disp('number of times move to state 4 or 5:');
disp(count(4)+count(5));
nextstates_mod=nextstates;

for i=1:size(nextstates_mod,1)
  for j=1:size(nextstates_mod,2)
    if nextstates_mod(i,j)==3
      nextstates_mod(i,j)=6;
    elseif nextstates_mod(i,j)==1
      nextstates_mod(i,j)=8;
    elseif nextstates_mod(i,j)==2
      nextstates_mod(i,j)=7;
    elseif nextstates_mod(i,j)==4
      nextstates_mod(i,j)=5;
    end
  end
end
hist(nextstates_mod(:));
axis([1 8 0 100000]);
figure(2);
bar(1:size(nextstates,1), nextstates_mod(:,2));
%#disp(nextstates);
%#disp(nextstates_mod);

end