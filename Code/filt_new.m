load('/Users/sunnysingh/Desktop/HarVi/curr_work/Force_Files/april2_silicone_200poke.mat')
fs=10000;
% take the first poke values of the data

N =7;  %first order
cutoff_Hz =200;  %should be 3dB down at the cutoff
[b,a]=butter(N,cutoff_Hz/(fs/2),'low');
new_data = [];
orig_data = [];
for k=1:length(dd)
    f=dd{1,k};
    g = f(:,3);
    meanoff = mean(g(1:50));
    g= f(:,3)-meanoff;
  
    filt= filter(b,a,g);
    filt=filt.*(-1);
    new_data = [new_data;filt];
    orig_data = [orig_data;g.*(-1)];
end
%new_data = new_data(new_data >= 0.12);
hold on;
plot(new_data);
hold on;

%histogram(new_data)

%plot(orig_data);
%csvwrite('/Users/sunnysingh/Desktop/HarVi/curr_work/CSV/April2/force_filtered_7_200Hz.csv',new_data)

%save('/Users/sunnysingh/Desktop/HarVi/curr_work/Force_Files/march23_force_filt.mat','newdata')


