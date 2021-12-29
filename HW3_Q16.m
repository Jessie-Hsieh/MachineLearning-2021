% HW3_Q3 12
for iter=1:200
Q=5;

cd('D:\110-1課程\HW3');
testID=fopen('test.txt');
C = textscan(testID,'%f');
test=C{1,1};
test=reshape(test,[11 size(C{1,1},1)/11])';
testdata(:,1)=ones(size(test,1),1);
randomidx=randperm(10);
idx(1:5)=randomidx(1:5);

for i=1:Q
testdata(:,i+1)=test(:,idx(i));
end
testdata_y=test(:,11);

trainID=fopen('train.txt');
C = textscan(trainID,'%f');
train=C{1,1};
train=reshape(train,[11 size(C{1,1},1)/11])';
traindata(:,1)=ones(size(train,1),1);
for i=1:Q
traindata(:,i+1)=train(:,idx(i));
end
traindata_y=train(:,11);
%linear regression

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


error_16(iter)=abs(error_in-error_out);
end
ans_16= mean(error_16)
%ans=0.21
