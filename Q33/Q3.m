clc
clear all
tic
y=zeros(200,10304);
v=zeros(200,10304);
IMG=zeros(200,112,92);

a1 = pwd ;
cd gallery
a2=pwd;
for i=1:40
    for j=1:5
        b=strcat(a2,'\','s',num2str(i),'\',num2str(j),'.pgm');
        I=imread(b);
        y(5*(i-1)+j,:)=I(:);
    end
end
cd ..
n=length(y(1,:));

u=mean(y);
Y=y-repmat(u(1,:),200,1);
sig1=Y*Y';
[V,D]=eig(sig1/200);
V2=Y'*V;
V2=normc(V2);
V3=V2;
%part 1
V2(:,1:195)=[];
V2=fliplr(V2);
z=V2'*y';
Z=V2*z;

% mkdir output3
% cd output3
% for k=1:200
%     IMG(k,:,:)=reshape(Z(:,k),[1,112,92]);
%     figure('Visible','off') 
%     H=imshow(mat2gray(reshape(IMG(k,:,:),[112,92])));
%     a=num2str(k);
%     saveas(H,a,'jpg');  
% end
% cd ..
% % part 1 end
% %part 2
% iter=1:200;
% lamb=zeros(1,200);
% su=sum(diag(D));
% lamb(1,1)=D(200,200);
% 
%  for i=2:200
%    lamb(1,i)=lamb(1,i-1)+(D(200-i+1,200-i+1));
%  end
%  lamb=lamb*100/su;
% k=find(lamb>=95);
% k(:,2:end)=[];
% figure()
% plot(iter,lamb);
% xlabel('No. of dimensions');
% ylabel('percentage of the total variance');
%part 2 end
%part 3 and 5
xl=zeros(2,10304);
IMG2=zeros(6,112,92);
I2=imread('face_input_1.pgm');
I3=imread('face_input_2.pgm');
xl(1,:)=I2(:);
xl(2,:)=I3(:);
V4=V3(:,200);
V5=V3(:,186:200);
V6=V3;
V4=fliplr(V4);
V5=fliplr(V5);
V6=fliplr(V6);

z1=zeros(1,2);
z2=zeros(15,2);
z3=zeros(200,2);

        for op=1:2
          z1(:,op)=V4'*xl(op,:)';
          z2(:,op)=V5'*xl(op,:)';
          z3(:,op)=V6'*xl(op,:)';          
        end

xlf1=(V4*z1);
xlf2=(V5*z2);
xlf3=(V6*z3);

%output3_5

mkdir out33
cd out33
%% 

    for op=1:2
            IMG2(3*op-2,:,:)=reshape(xlf1(:,op),[1,112,92]);
            IMG2(3*op-1,:,:)=reshape(xlf2(:,op),[1,112,92]);
            IMG2(3*op,:,:)=reshape(xlf3(:,op),[1,112,92]);
            figure('Visible','off') 
                for k=1:3
                        H=imshow(mat2gray(reshape(IMG2(3*op-k+1,:,:),[112,92])));
                        a=num2str(3*op-k+1);
                        saveas(H,a,'jpg'); 
                end
    end
     
cd ..

errx=[1 15 200]';
err=zeros(3,2);
i=1;
for i=1:2
    err(1,i)=sqrt((xl(i,:)-xlf1(:,i)')*(xl(i,:)-xlf1(:,i)')');
    err(2,i)=sqrt((xl(i,:)-xlf1(:,i)')*(xl(i,:)-xlf2(:,i)')');
    err(3,i)=sqrt((xl(i,:)-xlf3(:,i)')*(xl(i,:)-xlf3(:,i)')');   
end
err=err/n;
figure()
plot(errx,err(:,1),'g');
hold on 
plot(errx,err(:,2),'r');

toc






