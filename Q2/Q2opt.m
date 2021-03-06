clc
clear all
file=pwd;
I=imread('ski_image.jpg');
[a,b,~]=size(I);
n=a*b;
clear a b
x=double(zeros(n,3));
x(:)=I(:);
x=double(x/255);
p=[double(1/3);double(1/3);double(1/3)];
u=[120 120 120;12 12 12;180 180 180];
u=double(u/255);
sig=[double(eye(3)),double(eye(3)),double(eye(3))]';
itr=1;
res=double(zeros(n,4));
lhd=zeros(100,1);
suk=0;
P=probab(x,u,sig);

while itr<101
         tic
        for k=1:3
%             P(:,k)=P(:,k)*p(k,1);
            res(:,k)= P(:,k)*p(k,1);
        end
        normr(res(:,1:3));
        
        for i=1:n
            res(i,1:3)=res(i,1:3)./sum(res(i,1:3));
            maxk=max(res(i,1:3));
            if maxk == res(i,1)
    %             N(1,1)=N(1,1)+1;
                res(i,4)=1;
            end    
            if maxk == res(i,2)
    %             N(1,2)=N(1,2)+1;
                res(i,4)=2;
            end    
            if maxk == res(i,3)
    %             N(1,3)=N(1,3)+1;
                res(i,4)=3;
            end  
        end
    
    %respon end
    %mean
    uold=u;
%     u=zeros(3,3);
    u=res(:,1:3)'*x;
    
    for k=1:3                                          
        u(k,:)=u(k,:)/sum(res(:,k));
    end
    %meanend
    
    
    %sig 
    sig=double(zeros(9,3));
    
    for k=1:3
       for i=1:n
          sig(3*k-2:3*k,:)=sig(3*k-2:3*k,:)+res(i,k)*(x(i,:)-u(k,:))'*(x(i,:)-u(k,:)); 
       end
       sig(3*k-2:3*k,:)=sig(3*k-2:3*k,:)/sum(res(:,k));
       p(k,1)=sum(res(:,k))/n;
    end
    %sigend
    
    %Augmented image 
    %This part is commented so as to make computation fatser for llhd plot
     % file=pwd;
    % mkdir outq2
%     I2=reshape(y,321,481,3);
%     figure('Visible','off')
%     H=imshow(I2);
%     a=num2str(itr);
%     b=strcat(file,'\outq2\',a);
%     saveas(H,b,'jpg'); 
    
    %llhd
    P=probab(x,u,sig);
    prod=P*p;
    lhd(itr)=sum(log(prod));
    itr =itr+1;
    toc
end
h=figure;
 c=strcat(file,'plot');
  nitr=1:100;
  nitr=nitr';
  plot(nitr,lhd);
 saveas(h,c,'jpg');

