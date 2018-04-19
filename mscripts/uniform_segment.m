function [o1,o2,o3]=uniform_segment(data,s1_num,s2_num,s3_num)
%data : column vector of mfcc coefss. one row per frame
%segments=[];
%data(1:s1_num,:)
o1=[];
o2=[];
o3=[];

N_FEATURE=size(data,2);
N_OBS=size(data,2);

s1=1;
e1=s1+s1_num-1;
s2=e1+1;
e2=s2+s2_num-1;
s3=e2+1;
e3=e2+s3_num;

o1=data(s1:e1,:);
o2=data(s2:e2,:);
o3=data(s3:e3,:);


