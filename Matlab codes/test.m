clc;
clear all;
load myfile1.mat;
states=[[1,1,1] ; [1,1,2] ;[1,2,1] ;[2,1,1]; [1,2,2] ;[2,1,2] ;[2,2,1]; [2,2,2]];
rewards=zeros(2,8);
for i=1:8
    A=states(i,:);
    for j=1:2
        rewards(j,i)=sum((A==j).*[10 30 20])*10;
    end
end
syms        
   
    
