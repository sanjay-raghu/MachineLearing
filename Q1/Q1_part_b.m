clc
clear all
M1=zeros(200,32*32);
M2=zeros(600,32*32);
u=zeros(3,32*32);
sig = cell(3,1);
miss_classified=zeros(3,20);

tic ;
for j=1:3
    
file='C:\Users\sanjay raghuwanshi\Desktop\ML\Assignment_list1\Assignment_list\TrainCharacters\TrainCharacters\';

for i=1:200
   img= strcat(file,int2str(j),'\',int2str(i),'.jpg');
   e=imread(img);
   e1=imresize(e,[32 32]);
   M1(i,:)=e1(:);  
end
u(j,:)= mean(M1);
M2(200*(j-1)+i,:)= M1(i,:);

end
save('para.mat','u','sig');



% 
% clc
% clear all
% load('para.mat');
% sigma=cov(cell2mat(sig))+.7*eye(1024);
sigma=cov(M2)+.7*eye(1024);
count=[0 ;0 ; 0];
y=zeros(1,1024);

for j=1:3
    k=1;
    
    file='C:\Users\sanjay raghuwanshi\Desktop\ML\Assignment_list1\Assignment_list\TestCharacters\TestCharacters\TestCharacters\';
    
    for i=1:100
        img= strcat(file,int2str(j),'\',int2str(i+200),'.jpg');
        x1=imread(img);
        x=imresize(x1,[32 32]);
        y(:)= x(:);
        %   P1= log(mvnpdf(y,u(1,:),sigma(1:1024,1:1024)));
        %     P2=  log(mvnpdf(y,u(2,:),sigma(1025:2048,1:1024)));
        %    P3=  log(mvnpdf(y,u(3,:),sigma(2049:3072,1:1024)));
        P1 = -((y-u(1,:))*(inv(sigma))*(y-u(1,:))')-0.5*log(det(sigma));
        P2 = -((y-u(2,:))*(inv(sigma))*(y-u(2,:))')-0.5*log(det(sigma));
        P3 = -((y-u(3,:))*(inv(sigma))*(y-u(3,:))')-0.5*log(det(sigma));
        
        p=[P1 P2 P3];
        pmax = max(p);
        if pmax == P1 && j==1
            count(j)=count(j)+1;
        end
         if pmax ~= P1 && j==1
            miss_classified(j,k)= 200+i;
            k=k+1;
         end
        
         
        if pmax == P2 && j==2
            count(j)=count(j)+1;
        end
         if pmax ~= P2 && j==2
            miss_classified(j,k)= 200+i;
            k=k+1;
         end
        
         
        if pmax == P3 && j==3
            count(j)=count(j)+1;
        end
          if pmax ~= P3 && j==3
            miss_classified(j,k)= 200+i;
            k=k+1;
         end
        
        
    end
    
    
end
display(count);
miss_classified
save('acuracy_part_b.mat','count','miss_classified');
toc


