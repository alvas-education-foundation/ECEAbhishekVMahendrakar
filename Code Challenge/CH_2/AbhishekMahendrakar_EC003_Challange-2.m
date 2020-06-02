clc;
clear all;
close all;
d = xlsread('a01_3.csv');
Rdata = d(:,2)
Tdata = d(:,1)
%% Original ECG Signal Plotting
figure(1);

plot(Tdata,Rdata);
title('Original ECG Signal Plot');
xlabel('Time');
ylabel('Amplitude');

%% Butterworth filtering of ECG Signal
fp= 500;
fs= 80;
n= 2;
[b,a]= butter(n,fs/fp);
filter_signal = filter(b,a,Rdata);
figure(2)

plot(Tdata(1:1000),filter_signal(1:1000))
title('Butterworth filtered ECG Signal')
xlabel('Time');
ylabel('Amplitude');

%% Detecting R-Peaks using Pan Tompkins algorithm and Segregation of signal
R_D = Rdata
y=length(R_D);
fs = 200;              
N = length (R_D);       
t = [0:N-1]/fs;        
R_D = R_D - mean (R_D );    
R_D = R_D/ max( abs(R_D )) ;
b=[1 0 0 0 0 0 -2 0 0 0 0 0 1];
a=[1 -2 1];
h=filter(b,a,[1 zeros(1,12)]); 
x1 = conv (R_D ,h);
x1 = x1/ max( abs(x1 )); 
b = [-1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 32 -32 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];
a = [1 -1];
h1=filter(b,a,[1 zeros(1,32)]); 
x2 = conv (x1 ,h1);
x2 = x2/ max( abs(x2 ));
h = [-1 -2 0 2 1]/8;
x3 = conv (x2 ,h);
x3 = x3 (2+[1: N]);
x3 = x3/ max( abs(x3 ));
figure(3)
subplot(2,1,1);
plot([0:length(x3)-1]/fs,x3);
subplot(2,1,2);
plot(t(200:600),x3(200:600));
title('Segregated signal');
xlim([1 3])
x4 = x3 .^2;
x4 = x4/ max( abs(x4 ));
h = ones (1 ,31)/31;
Delay = 15; 
x5 = conv (x4 ,h);
x5 = x5 (15+[1: N]);
x5 = x5/ max( abs(x5 ));
maxr = max(x5);
thresh = mean (x5 );
k=thresh*maxr;
y =(x5>k)';
left = find(diff([0 y])==1);
right = find(diff([y 0])==-1);
left=left-20;
for i=1:length(left)
   [R2(i) Rl(i)] = max( R_D(left(i):right(i)) );
   Rl(i) = Rl(i)+left(i) ;
   for j=1:20
   x(j)=left(j);
  for l=1:20;
  k(l)=left(j)-left(j+1);
  y=-1*mean2(k(l));
  end
 end
end
figure(4)
plot (t,R_D/max(R_D) , t(Rl) ,R2 , 'r*');
title('Detection of R-Peaks in segrigated signal');
xlabel('Time');
ylabel('Amplitude');
xlim([1 3])