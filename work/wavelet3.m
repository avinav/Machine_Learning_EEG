% clear all;
% close all;
% % t1=0;
% t2=1;
% dt=0.001;
% t=t1:dt:t2;
% x=zeros(1,1001);
% x(1:250)=sin(2*pi*25*t(1:250));
% x(251:500)=sin(2*pi*50*t(251:500));
% x(501:750)=sin(2*pi*100*t(501:750));
% x(751:1000)=sin(2*pi*400*t(751:1000));
% % data=load('Subject1_2D.mat');
% % x=data.LeftBackward1;
function wavelet3(x,po,flag3)
% xx=load('left.mat');
% x=xx.x;

% figure, plot(x);
[ca,cd]=dwt(x,'db2');     %f=250/2=125
[ca1,cd1]=dwt(ca,'db2');       %f=125/2=62.5
[ca2,cd2]=dwt(ca1,'db2');      %f=62.5/2=31.25
[ca3,cd3]=dwt(ca2,'db2');       %f=31.25/2=15.625
[ca4,cd4]=dwt(ca3,'db2');       %f=15.625/2=7.8125
%  [ca5,cd5]=dwt(ca4,'db2');      %12.5/2=6.25
% cd4
 mlp_eeg1(cd4,po,flag3);
 % size(ca)
% size(ca1)
% size(ca2)
% size(ca3)
% size(ca4)
% size(ca5)
% figure();
% subplot(221)
% plot(ca);
% subplot(222)
% plot(ca1);
% subplot(223)
% plot(ca2);
% subplot(224)
% plot(ca3);
% % subplot(325)
% % plot(ca4);
% figure();
% subplot(221)
% plot(cd);
% subplot(222)
% plot(cd1);
% subplot(223)
% plot(cd2);
% subplot(224)
% plot(cd3);
% subplot(325)
% plot(cd4);

% figure, plot(ca);
% figure, plot(cd);