% HW3_Q3 14

cd('D:\110-1課程\HW3');
testID=fopen('test.txt');
C = textscan(testID,'%f');
test=C{1,1};
test=reshape(test,[11 size(C{1,1},1)/11])';
testdata(:,1)=ones(size(test,1),1);
testdata(:,2:11)=test(:,1:10);
testdata_y=test(:,11);

trainID=fopen('train.txt');
C = textscan(trainID,'%f');
train=C{1,1};
train=reshape(train,[11 size(C{1,1},1)/11])';
traindata(:,1)=ones(size(train,1),1);
traindata(:,2:11)=train(:,1:10);
traindata_y=train(:,11);


%linear regression
for n=1:10
w_lin=pinv(traindata(:,1:1+n)'*traindata(:,1:1+n))*traindata(:,1:1+n)'*traindata_y;
%%error in sample
s_in_lin=traindata(:,1:1+n)*w_lin;
h_in=traindata_y.*s_in_lin;
 error_in(n)=0;
for i=1:size(s_in_lin,1)
if h_in(i)<0
    error_in(n)=error_in(n)+1;
end   
end
error_in(n)=error_in(n)/size(s_in_lin,1);

%%error out sample
s_out_lin=testdata(:,1:1+n)*w_lin;
error_out(n)=0;
h_out=testdata_y.*s_out_lin;
for i=1:size(s_out_lin,1)
if h_out(i)<0
    error_out(n)=error_out(n)+1;
end   
end
error_out(n)=error_out(n)/size(s_out_lin,1);


error_14(n)=abs(error_in(n)-error_out(n))

end
%ans=3
