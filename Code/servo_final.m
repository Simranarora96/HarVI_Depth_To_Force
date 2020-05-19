clc;
close all;
devices = daq.getVendors();
% If you don't know the device name you can uncomment the above line and
% replace Dev2 with the device name in the following lines.

s = daq.createSession(devices(1).ID());

ch1=addAnalogInputChannel(s,'Dev1', 'ai0', 'Voltage'); %Force-X
ch1.TerminalConfig = 'Differential';
ch1.Range = [-10,10];
ch2=addAnalogInputChannel(s,'Dev1', 'ai1', 'Voltage'); %Force-Y
ch2.TerminalConfig = 'Differential';
ch2.Range = [-10,10];
ch3=addAnalogInputChannel(s,'Dev1', 'ai2', 'Voltage'); %Force-Z
ch3.TerminalConfig = 'Differential';
ch3.Range = [-10,10];
ch4=addAnalogInputChannel(s,'Dev1', 'ai3', 'Voltage'); %Torque-X
ch4.TerminalConfig = 'Differential';
ch4.Range = [-10,10];
ch5=addAnalogInputChannel(s,'Dev1', 'ai4', 'Voltage'); %Torque-y
ch5.TerminalConfig = 'Differential';
ch5.Range = [-10,10];
ch6=addAnalogInputChannel(s,'Dev1', 'ai5', 'Voltage'); %Torque-Z
ch6.TerminalConfig = 'Differential';
ch6.Range = [-10,10];

ch7= addAnalogInputChannel(s,'Dev1', 6, 'Voltage'); %Servo motor position reader
ch8=addCounterOutputChannel(s,'Dev1', 0, 'PulseGeneration'); %Servo motor signal generator
ch8.Frequency = 1/0.02;
ch8.InitialDelay = 0.1;
% Top: 0.053
% Bottom: 0.095
n=18;
dd={};

while n > 0
    if(mod(n,2)==0)
        ch8.DutyCycle = 0.074-n*0.0005;
    else
        ch8.DutyCycle = 0.053;
    end
    
    s.DurationInSeconds = 3;
    s.Rate = 1000;
     % Change this time based on your need for reading the force sensor
    % This time is independent of your servo signal
    [Data, time] = s.startForeground();
    Offset = Data(1,1:6);
    %%
    Fx= [0.00218   0.00777  -0.07732  -3.31152   0.02261   3.28962];
    Fy= [-0.02655   4.05829  -0.06129  -1.88839  -0.00746  -1.91908];
    Fz= [3.79085   0.00200   3.81456  -0.06195   3.81532  -0.07418];
    Tx= [-0.77256  24.43408  20.89700 -11.69060 -21.72983 -11.19770];
    Ty= [-23.58908  -0.08840  12.77264  19.82763  12.98916 -20.10740];
    Tz= [0.01391  14.38601   0.36843  13.98652   0.25728  14.55357];
    Calib = [Fx;Fy;Fz;Tx;Ty;Tz];
    
    for i = 1:size(Data,1)
         Data(i,1:6) = (Data(i,1:6)-Offset)*Calib;
    end
    dd{19-n} = [Data,time];
%     pause(1)
    n = n-1;
    
end

