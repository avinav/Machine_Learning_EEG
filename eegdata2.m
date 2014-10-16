clear all;
close all;
flagg=1;
flag3=1;
xx=load('Subject1_2D.mat');
while flagg<=6
    if flagg==1
        x=xx.LeftBackward1;
        po=[1 -1 -1 -1 -1];
    else if flagg==2
           x=xx.LeftBackward2;
                        po=[1 -1 -1 -1 -1];
        else if flagg==3
                x=xx.LeftBackward3;
                po=[1 -1 -1 -1 -1];
            else if flagg==4
                    x=xx.LeftForward1;
                                po=[-1 -1 -1 -1 1];
                else if flagg==5
                         x=xx.LeftForward2;
            po=[-1 -1 -1 -1 1];
                       
                    else if flagg==6
                            x=xx.LeftForward3;
                            po=[-1 -1 -1 -1 1];
%                         else if flagg==7
%                                     xx=load('right3.mat');
%                                     po=[-1 -1 -1 -1 1];
%                             else if flagg==8
%                                     xx=load('right1.mat');
%                     po=[-1 -1 -1 -1 1];
%                        
%                                 end
%                             end
                        end
                    end
                end
            end
        end
    end
    flagg=flagg+1;

                              

electrode=4;
Fs = 500;                    % Sampling frequency
% T = 1/Fs;                     % Sample time
L = 3008;                     % Length of signal
% t = (0:L-1)*T;                % Time vector
% plot(Fs*t,x(:,1))
%  
% NFFT = 2^nextpow2(L); % Next power of 2 from length of x
% Y = fft(x(:,1),NFFT)/L;
% f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.

[Y,NFFT,f]=fft2(x(:,electrode),Fs,L);
% figure();
% plot(f,2*abs(Y(1:NFFT/2+1))) 
% title('Single-Sided Amplitude Spectrum of y(t)')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')


% breaking into 5 samples of 1 seconds

% figure();
L=300;
Y1=zeros(2^nextpow2(L),10);
[Y1(:,1),NFFT,f]=fft2(x(1:L,electrode),Fs,L);
% subplot(4,3,1)
% plot(f,2*abs(Y1(1:NFFT/2+1,1))) 

[Y1(:,2),NFFT,f]=fft2(x(L:2*L,electrode),Fs,L);
% subplot(4,3,2)
% plot(f,2*abs(Y1(1:NFFT/2+1,2))) 

[Y1(:,3),NFFT,f]=fft2(x(2*L:3*L,electrode),Fs,L);
% subplot(4,3,3)
% plot(f,2*abs(Y1(1:NFFT/2+1,3))) 

[Y1(:,4),NFFT,f]=fft2(x(3*L:4*L,electrode),Fs,L);
% subplot(4,3,4)
% plot(f,2*abs(Y1(1:NFFT/2+1,4))) 

[Y1(:,5),NFFT,f]=fft2(x(4*L:5*L,electrode),Fs,L);
% subplot(4,3,5)
% plot(f,2*abs(Y1(1:NFFT/2+1,5))) 

[Y1(:,6),NFFT,f]=fft2(x(5*L:6*L,electrode),Fs,L);
% subplot(4,3,6)
% plot(f,2*abs(Y1(1:NFFT/2+1,6))) 

[Y1(:,7),NFFT,f]=fft2(x(6*L:7*L,electrode),Fs,L);
% subplot(4,3,7)
% % plot(f,2*abs(Y1(1:NFFT/2+1,7))) 

[Y1(:,8),NFFT,f]=fft2(x(7*L:8*L,electrode),Fs,L);
% subplot(4,3,8)
% plot(f,2*abs(Y1(1:NFFT/2+1,8))) 

[Y1(:,9),NFFT,f]=fft2(x(8*L:9*L,electrode),Fs,L);
% subplot(4,3,9)
% plot(f,2*abs(Y1(1:NFFT/2+1,9))) 

[Y1(:,10),NFFT,f]=fft2(x(9*L:10*L,electrode),Fs,L);
% subplot(4,3,10)
% plot(f,2*abs(Y1(1:NFFT/2+1,10))) 

%comparing the alpha/beta/mu ranges of the samples
findexi=ceil((length(f)/(Fs/2))*8);
findexf=ceil((length(f)/(Fs/2))*12);
maxy=zeros(1,10);

for i=1:10
    maxy(i)=max(abs(Y1(findexi:findexf,i)));
    if i==1
        selsample=maxy(i);
        ssindex=i;
    end
    if i>1 && maxy(i)>=selsample
        selsample=maxy(i);
        ssindex=i;
    end
end
if ssindex==1
    wavelet3(x(1:L,electrode),po,flag3);
else
    wavelet3(x((ssindex-1)*L:ssindex*L,electrode),po,flag3);
end
% 
flag3=flag3+1;
end


