clc
clear all
load('Pattern1.mat');
load('Pattern2.mat');
load('Pattern3.mat');

training_sample1 = cell2mat(train_pattern_1);
training_sample1 = reshape(training_sample1,120,200)';

training_sample2 = cell2mat(train_pattern_2);
training_sample2 = reshape(training_sample2,120,200)';

training_sample3 = cell2mat(train_pattern_3);
training_sample3 = reshape(training_sample3,120,200)';
training_sample=zeros(600,120);
training_sample(1:200,:)=training_sample1;
training_sample(201:400,:)=training_sample2;
training_sample(401:600,:)=training_sample3;


% training_sample = [training_sample1;training_sample2;training_sample3];

clear training_sample1 training_sample2 training_sample3 train_pattern_1 train_pattern_2 train_pattern_3



load('Test1.mat');
load('Test2.mat');
load('Test3.mat');

test1 = cell2mat(test_pattern_1);
test1 = reshape(test1,120,100)';

test2 = cell2mat(test_pattern_2);
test2 = reshape(test2,120,100)';

test3 = cell2mat(test_pattern_3);
test3 = reshape(test3,120,100)';
testing_sample=zeros(300,120);
testing_sample(1:100,:)= test1 ;
testing_sample(101:200,:)=test2 ;
testing_sample(201:300,:)= test3 ;

% testing_sample = [test1;test2;test3];

clear test1 test2 test3 test_pattern_1 test_pattern_2 test_pattern_3

trainlabel1=zeros(600,1);
trainlabel2=zeros(600,1);
trainlabel3=zeros(600,1);

i=1:200 ;
trainlabel1(i) = ones(200,1);
trainlabel2(200+i)=ones(200,1);
trainlabel3(400+i)=ones(200,1);


clear i 





counter = 1;
acc = zeros(2500,1);
for C=0.1:0.2:10
    for G=0.1:0.2:10
%     b=strcat(a,'-c ',num2str(C),'-g ',num2str(gamma));
    model1 = svmtrain(training_sample,trainlabel1,'kernel_function','rbf','RBF_Sigma', G,'BoxConstraint', C);
   model2 = svmtrain(training_sample,trainlabel2,'kernel_function','rbf','RBF_Sigma', G,'BoxConstraint', C);
    model3 = svmtrain(training_sample,trainlabel3,'kernel_function','rbf','RBF_Sigma', G,'BoxConstraint', C);
    result1 = svmclassify(model1,testing_sample);
    result2 = svmclassify(model2,testing_sample);
    result3 = svmclassify(model3,testing_sample);
    
    acc(counter,1) = (sum(result1(1:100))+sum(result2(101:200))+sum(result3(201:300)))/3;
    counter = counter + 1;
    end
    
end

counter = 1;
ACC_PLOT = zeros(2500,3);


for C=0.1:0.2:10
    for G=0.1:0.2:10
        ACC_PLOT(counter,1)=C;
        ACC_PLOT(counter,2)=G;
%         ACC_PLOT(counter,3)=acc(counter);
        counter=counter+1;
    end
end
ACC_PLOT(:,3) = acc;


plot3(ACC_PLOT(:,1),ACC_PLOT(:,2),ACC_PLOT(:,3));
