clear all
close all
clc 
x=imread('frc.jpg');
x1=x(:); % convert to rows matrix with 1 coulmn
[m n]=size(x);
[cnt1,aaa]=size(x1(:)); % cnt1 rpresents rows while aaa represent coulmn
% histogram
h= zeros(1,256);
for i=1:256 
    for j=1:m
        for k=1:n
        if ((i-1)==x(j,k))  
         h(1,i)=h(1,i)+1;
        end
    end
    end
end
%probability
p=h/(cnt1*aaa); %occurance devided by no of pixels(no of rows * no of coulmns)
a=0:255;
mean=p.*a;
p1=zeros(1,256);
p2=zeros(1,256);
m1=zeros(1,256);
m2=zeros(1,256);
var=zeros(1,256);
minimum=1;%min(x1); % minimum value of image
maximum=256;max(x1); % maximum value of image
for i=minimum:maximum
    p1(i)=sum(p(minimum:i));
    p2(i)=1-p1(i);
    
    m1(i)=sum(mean(minimum:i))/p1(i);% mean of class A
    m2(i)=sum(mean(i+1:maximum))/p2(i);% % mean of class B
   
    mg=p1(i)*m1(i)+p2(i)*m2(i); %global mean
    var(i)=p1(i)*(m1(i)-mg).^2+p2(i)*(m2(i)-mg).^2; % between Class Variance
end
% finding index number of maximum value of variance
for i=minimum:maximum
    if var(i)==max(var)
        index=i;
        break
    end
end
% Threshholding/Binarization
for i=1:m
    for j=1:n
        if x(i,j)<=index;
            y(i,j)=0;
        else
            y(i,j)=1;
        end
    end
end
% figures
figure(1);
imshow(x);
figure(2);
bar(h);
figure(3)
imshow(y);
    
    