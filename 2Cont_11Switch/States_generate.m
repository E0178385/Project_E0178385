function [states]=States_generate()
Sw=11;
N=2;
states=zeros(2^11,11);
i=1;
for a=1:2,
    for b=1:2,
        for c=1:2,
            for d=1:2,
                for e=1:2,
                    for a1=1:2,
                       for b1=1:2,
                           for c1=1:2,
                               for d1=1:2,
                                   for e1=1:2.
                                       for a2=1:2,
                                           
                                           states(i,:)=[a b c d e a1 b1 c1 d1 e1 a2];
                                           i=i+1;
                                        end;
                                    end;
                                end;
                            end;
                        end;

                    end;
                end;
            end;
        end;
    end;
end;
end

