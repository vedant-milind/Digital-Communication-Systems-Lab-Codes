clc;
clear all;
close all;

%Define transmitted signal
N=10; % Number of bits , size of transmitted signal x_inp=[x_1 x_2 ... x_N] 
n= randi([0, 1],1,N);  % binary signal 0 or 1 % message to be transmitted                               
Tb=1; % bit period (second)   

%Represent input signal as digital signal
x_bit=[]; 
s=100; % bbit/bit
for i=1:1:N   % 
    if n(i)==1;  % 
       nn=ones(1,s);
    else n(i)==0;
        nn=zeros(1,s);
    end
     x_bit=[x_bit nn];
end


t1=Tb/s:Tb/s:s*N*(Tb/s); % time of the signal 
f1 = figure(1);
set(f1,'color',[1 1 1]);
subplot(3,1,1);
plot(t1,x_bit);
axis([ 0 Tb*N -0.5 1.5]);
ylabel('Amplitude');
xlabel('Time');
title('Input signal');



%Define BASK Modulation
Ac1=15; % Amplitude of carrier signal for bit 1
Ac2=0; % Amplitude of carrier signal for bit 0
mc=10;  % fc>>fs fc=mc*fs fs=1/Tb 
fc=mc*(1/Tb); % carrier frequency 
t2=Tb/s:Tb/s:Tb;                 
t2L=length(t2);
x_mod=[];
for (i=1:1:N)
    if (n(i)==1)
        x_mod0=Ac1*cos(2*pi*fc*t2);%modulation signal with carrier signal 1
    else
        x_mod0=Ac2*cos(2*pi*fc*t2);%modulation signal with carrier signal 2
    end
    x_mod=[x_mod x_mod0];
end
t3=Tb/s:Tb/s:Tb*N;
subplot(3,1,2);
plot(t3,x_mod);
xlabel('Time');
ylabel('Amplitude');
title('Signal of  BASK modulation ');

x=x_mod; %Transmitted signal x 

%Channel model h and w
h=1; % Fading 
w=0; % Noise

% Received signal y
y=h.*x+w;


%Define BASK Demodulation

y_dem=[];
for i=t2L:t2L:length(y)
  t=Tb/s:Tb/s:Tb;
  c=cos(2*pi*fc*t); % carrier siignal 
  y_dem0=c.*y((i-(t2L-1)):i);
  t4=Tb/s:Tb/s:Tb;
  z=trapz(t4,y_dem0); % intregation 
  A_dem=round((2*z/Tb));                                     
  if(A_dem>((Ac1+Ac2)/2)) % logic level = (Ac1+Ac2)/2
    A=1;
  else
    A=0;
  end
  y_dem=[y_dem A];
end

x_out=y_dem; % output signal;

%Represent output signal as digital signal 
xx_bit=[];
for i=1:length(x_out);
    if x_out(i)==1;
       xx_bitt=ones(1,s);
    else x_out(i)==0;
        xx_bitt=zeros(1,s);
    end
     xx_bit=[xx_bit xx_bitt];

end
t4=Tb/s:Tb/s:s*length(x_out)*(Tb/s);
subplot(3,1,3)
plot(t4,xx_bit);
axis([ 0 Tb*length(x_out) -0.5 1.5]);
ylabel('Amplitude');
xlabel('Time');
title('Output signal');

% ********************* BPSK modulation and de-modulation ****************%


% ********************* Define transmitted signal *************************

N=10; % Number of bits , size of transmitted signal x_inp=[x_1 x_2 ... x_N] 
x_inp= n;  % binary signal 0 or 1 % message to be transmitted                               
Tb=0.0001; % bit period (second)   


% ********************* Represent input signal as digital signal ****
x_bit=[]; 
nb=100; % bbit/bit
for n=1:1:N   % 
    if x_inp(n)==1;  % 
       x_bitt=ones(1,nb);
    else x_inp(n)==0;
        x_bitt=zeros(1,nb);
    end
     x_bit=[x_bit x_bitt];
end

t1=Tb/nb:Tb/nb:nb*N*(Tb/nb); % time of the signal 
f1 = figure(1);
set(f1,'color',[1 1 1]);
subplot(3,1,1);
plot(t1,x_bit,'lineWidth',2);grid on;
axis([ 0 Tb*N -0.5 1.5]);
ylabel('Tmplitude(volt)');
xlabel(' Time(sec)');
title('Input signal as digital signal');


% ********************* Define BPSK Modulation ****************************
Ac=5;  % Amplitude of carrier signal
mc=4;  % fc>>fs fc=mc*fs fs=1/Tb
fc=mc*(1/Tb); % carrier frequency for bit 1
fi1=0; % carrier phase for bit 1
fi2=pi; % carrier phase for bit 0
t2=Tb/nb:Tb/nb:Tb;                 
t2L=length(t2);
x_mod=[];
for (i=1:1:N)
    if (x_inp(i)==1)
        x_mod0=Ac*cos(2*pi*fc*t2+fi1);%modulation signal with carrier signal 1
    else
        x_mod0=Ac*cos(2*pi*fc*t2+fi2);%modulation signal with carrier signal 2
    end
    x_mod=[x_mod x_mod0];
end
t3=Tb/nb:Tb/nb:Tb*N;
subplot(3,1,2);
plot(t3,x_mod);
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Signal of  BASK modulation ');


% ********************* Transmitted signal x ******************************
x=x_mod;

% ********************* Channel model h and w *****************************
h=1; % Fading 
w=0; % Noise

% ********************* Received signal y *********************************
y=h.*x+w;


% ********************* Define BPSK Demodulation **************************

y_dem=[];
for n=t2L:t2L:length(y)
  t=Tb/nb:Tb/nb:Tb;
  c=cos(2*pi*fc*t); % carrier siignal 
  y_dem0=c.*y((n-(t2L-1)):n);
  t4=Tb/nb:Tb/nb:Tb;
  z=trapz(t4,y_dem0); % intregation 
  A_dem=round((2*z/Tb));                                     
  if(A_dem>Ac/2) % logic level = Ac/2
    A=1;
  else
    A=0;
  end
  y_dem=[y_dem A];
end

x_out=y_dem; % output signal;

% *************** Represent output signal as digital signal ***************
xx_bit=[];
for n=1:length(x_out);
    if x_out(n)==1;
       xx_bitt=ones(1,nb);
    else x_out(n)==0;
        xx_bitt=zeros(1,nb);
    end
     xx_bit=[xx_bit xx_bitt];

end
t4=Tb/nb:Tb/nb:nb*length(x_out)*(Tb/nb);
subplot(3,1,3)
plot(t4,xx_bit,'LineWidth',2);grid on;
axis([ 0 Tb*length(x_out) -0.5 1.5]);
ylabel('Amplitude(volt)');
xlabel(' Time(sec)');
title('Output signal as digital signal');

% ********************* BFSK modulation and de-modulation ****************%


% ********************* Define transmitted signal *************************

N=10; % Number of bits , size of transmitted signal x_inp=[x_1 x_2 ... x_N] 
x_inp = x_inp;  % binary signal 0 or 1 % message to be transmitted                               
Tb=0.0001; % bit period (second)   


% ********************* Represent input signal as digital signal ****
x_bit=[]; 
nb=100; % bbit/bit
for n=1:1:N   % 
    if x_inp(n)==1;  % 
       x_bitt=ones(1,nb);
    else x_inp(n)==0;
        x_bitt=zeros(1,nb);
    end
     x_bit=[x_bit x_bitt];
end

t1=Tb/nb:Tb/nb:nb*N*(Tb/nb); % time of the signal 
f1 = figure(1);
set(f1,'color',[1 1 1]);
subplot(3,1,1);
plot(t1,x_bit,'lineWidth',2);grid on;
axis([ 0 Tb*N -0.5 1.5]);
ylabel('Tmplitude(volt)');
xlabel(' Time(sec)');
title('Input signal as digital signal');



% ********************* Define BFSK Modulation ****************************
Ac=5;  % Amplitude of carrier signal
mc1=16;  % fc>>fs fc=mc*fs fs=1/Tb
mc2=4;
fc1=mc1*(1/Tb); % carrier frequency for bit 1
fc2=mc2*(1/Tb); % carrier frequency for bit 0
t2=Tb/nb:Tb/nb:Tb;                 
t2L=length(t2);
x_mod=[];
for (i=1:1:N)
    if (x_inp(i)==1)
        x_mod0=Ac*cos(2*pi*fc1*t2);%modulation signal with carrier signal 1
    else
        x_mod0=Ac*cos(2*pi*fc2*t2);%modulation signal with carrier signal 2
    end
    x_mod=[x_mod x_mod0];
end
t3=Tb/nb:Tb/nb:Tb*N;
subplot(3,1,2);
plot(t3,x_mod);
xlabel('Time(sec)');
ylabel('Amplitude(volt)');
title('Signal of  BASK modulation ');

% ********************* Transmitted signal x ******************************
x=x_mod;

% ********************* Channel model h and w *****************************
h=1; % Fading 
w=0; % Noise

% ********************* Received signal y *********************************
y=h.*x+w;


% ********************* Define BFSK Demodulation **************************
y_dem=[];
for n=t2L:t2L:length(y)
  t=Tb/nb:Tb/nb:Tb;
  c_dem1=cos(2*pi*fc1*t); % carrier siignal for information 1
  c_dem2=cos(2*pi*fc2*t); % carrier siignal for information 0
  y_dem1=c_dem1.*y((n-(t2L-1)):n);
  y_dem2=c_dem2.*y((n-(t2L-1)):n);
  t4=Tb/nb:Tb/nb:Tb;
  z1=trapz(t4,y_dem1);  % intregation 
  z2=trapz(t4,y_dem2);  % intregation 
  A_dem1=round(2*z1/Tb);
  A_dem2= round(2*z2/Tb);
  if(A_dem1>Ac/2)      % % logic level = (Ac)/2
    a=1;
  else(A_dem2>Ac/2)
    a=0;
  end
  y_dem=[y_dem a];
end

x_out=y_dem; % output signal;


% *************** Represent output signal as digital signal ***************
xx_bit=[];
for n=1:length(x_out);
    if x_out(n)==1;
       xx_bitt=ones(1,nb);
    else x_out(n)==0;
        xx_bitt=zeros(1,nb);
    end
     xx_bit=[xx_bit xx_bitt];

end
t4=Tb/nb:Tb/nb:nb*length(x_out)*(Tb/nb);
subplot(3,1,3)
plot(t4,xx_bit,'LineWidth',2);grid on;
axis([ 0 Tb*length(x_out) -0.5 1.5]);
ylabel('Amplitude(volt)');
xlabel(' Time(sec)');
title('Output signal as digital signal');

