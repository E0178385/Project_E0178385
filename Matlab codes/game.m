function s=game(P)
  s=zeros(size(P,1),1);
  for i=1:size(P,1)
    p=[0 P(i,2:size(P,1)-1) 0];
    [~,b]=max(p);
    ns=b;
    gs=b;
    for j=1:10
      p=[0 P(ns,2:size(P,1)-1) 0];
      [~,b]=max(p);
      ns=b;
      if ns==gs
        s(i)=gs;
        break;
      end
    end
  end
end
     