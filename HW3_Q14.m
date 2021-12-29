% HW3_Q3 14

cd('D:\110-1課程\HW3');
testID=fopen('test.txt');
C = textscan(testID,'%f');
test=C{1,1};
test=reshape(test,[11 size(C{1,1},1)/11])';
testdata(:,1)=ones(size(test,1),1);
testdata(:,2:11)=test(:,1:10);
t=0;
for i=1:10
    for j=i:10
        testdata(:,12+t)=test(:,i).*test(:,j);
        t=t+1
    end
end
testdata_y=test(:,11);

trainID=fopen('train.txt');
C = textscan(trainID,'%f');
train=C{1,1};
train=reshape(train,[11 size(C{1,1},1)/11])';
traindata(:,1)=ones(size(train,1),1);
traindata(:,2:11)=train(:,1:10);
t=0;
for i=1:10
    for j=i:10
        traindata(:,12+t)=train(:,i).*train(:,j);
        t=t+1;
    end
end
traindata_y=train(:,11);


%linear regression
%%
v = allVL1(3, 3, '==',100);
%%

w_lin=pinv(traindata'*traindata)*traindata'*traindata_y;
%%error in sample
s_in_lin=traindata*w_lin;
h_in=traindata_y.*s_in_lin;
 error_in=0;
for i=1:size(s_in_lin,1)
if h_in(i)<0
    error_in=error_in+1;
end   
end
error_in=error_in/size(s_in_lin,1);

%%error out sample
s_out_lin=testdata*w_lin;
error_out=0;
h_out=testdata_y.*s_out_lin;
for i=1:size(s_out_lin,1)
if h_out(i)<0
    error_out=error_out+1;
end   
end
error_out=error_out/size(s_out_lin,1);


ans_13=abs(error_in-error_out)

%ans=0.33
