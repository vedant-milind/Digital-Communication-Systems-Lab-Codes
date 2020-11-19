clc;
clear;
close all;
 
M=4;
nbit=16;
msg=round(rand(nbit,1));
disp('Binary information at transmitter ');
disp(msg);
fprintf('\n');
 
x=msg;
bp=.000001;
bit=[]; 
for n=1:1:length(x)
    if x(n)==1
       se=ones(1,100);
    elseif x(n)==0
        se=zeros(1,100);
    end
     bit=[bit se];
end
 
t1=bp/100:bp/100:100*length(x)*(bp/100);
 
figure(1)
subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('Amplitude(volt)');
xlabel('Time(sec)');
title('Transmitting information as digital signal');
 
msg_reshape=reshape(msg,log2(M),nbit/log2(M))';
disp('Information is reshaped to convert to symbolic form');
disp(msg_reshape);
fprintf('\n');
 
size(msg_reshape);
for j=1:1:nbit/log2(M)
   for i=1:1:log2(M)
       a(j,i)=num2str(msg_reshape(j,i));
   end
end
 
as=bin2dec(a);
ass=as';
figure(1)
subplot(3,1,2);
stem(ass,'Linewidth',2.0);
title('Serial symbol for M-ary modulation at transmitter');
xlabel('n(discrete time)');
ylabel(' magnitude');
 
disp('Symbolic form information for M-ary');
disp(ass);
fprintf('\n');
 
x1=[0:M-1];
p=qammod(ass,M);
sym=0:1:M-1;
pp=qammod(sym,M);         
scatterplot(pp),grid on;
title('Constellation diagram for M-ary');
 
RR=real(p);
II=imag(p);
sp=bp*2;                        
sr=1/sp;                           
f=sr*2;
t=sp/100:sp/100:sp;
ss=length(t);
m=[];
for k=1:1:length(RR)
    yr=RR(k)*cos(2*pi*f*t);
    yim=II(k)*sin(2*pi*f*t); 
    y=yr+yim;
    m=[m y];
end
 
tt=sp/100:sp/100:sp*length(RR);
 
figure(1);
subplot(3,1,3);
plot(tt,m);
title('Waveform for M-ary modulation according to symbolic information');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
 
figure(3);
om=awgn(m,15);
subplot(3,1,1);
plot(tt,om);
title('Waveform for M-ary modulation acording to symbolic information with noise');
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
 
% M-ary demodulation
m1=[];
m2=[];
for n=ss:ss:length(om)
  t=sp/100:sp/100:sp;
  y1=cos(2*pi*f*t);
  y2=sin(2*pi*f*t);
  mm1=y1.*m((n-(ss-1)):n);                                    
  mm2=y2.*m((n-(ss-1)):n);                                    
  z1=trapz(t,mm1); 
  z2=trapz(t,mm2);
  zz1=round(2*z1/sp);
  zz2=round(2*z2/sp);
  m1=[m1 zz1];
  m2=[m2 zz2];
end
 
clear i;
clear j;
for(k=1:1:length(m1))  
    gt(k)=m1(k)+j*m2(k);
end
 
ax=qamdemod(gt,M);
subplot(3,1,2);
stem(ax,'linewidth',2);
title('Re-obtained symbol after M-ary demodulation ');
xlabel('n(discrete time)');
ylabel('Magnitude');
 
disp('Re-obtained symbol after M-ary demodulation ');
disp(ax);
fprintf('\n');
 
bi_in=dec2bin(ax);
[row col]=size(bi_in);
p=1;
 for(i=1:1:row)
     for(j=1:1:col)
         re_bi_in(p)=str2num(bi_in(i,j));
         p=p+1;
     end
 end 
disp('Re-obtained binary information after M-ary demodulation');
disp(re_bi_in')
fprintf('\n');
x=re_bi_in;
bp=.000001;                                                    
bit=[]; 
for n=1:1:length(x)
    if x(n)==1
       se=ones(1,100);
    elseif x(n)==0
        se=zeros(1,100);
    end
     bit=[bit se];
 
end
 
t1=bp/100:bp/100:100*length(x)*(bp/100);
 
figure(3)
subplot(3,1,3);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('Amplitude(volt)');
xlabel('Time(sec)');
title('Receiving information as digital signal after M-ary demoduation');
