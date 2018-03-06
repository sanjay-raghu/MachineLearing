function[P]=probab(x,u,sig)

[n,~]=size(x);
P=double(zeros(n,3));
for k=1:3 
    for i=1:n
      P(i,k)=gauspdf(x(i,:),u(k,:),sig(3*k-2:3*k,:));
    end
end
end