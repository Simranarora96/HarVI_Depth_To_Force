depth = table2array(readtable('/Users/sunnysingh/Desktop/HarVi/curr_work/CSV/April2/final_sample_orig_200poke_depth_exp0.csv'));
force = table2array(readtable('/Users/sunnysingh/Desktop/HarVi/curr_work/CSV/April2/final_sample_orig_200poke_force_exp0.csv'));
%B = depth >= 0.0946;
% depth = depth(B);
% force = force(force >= 0.0946);
% depth(depth <= 0.094) = [];
% force(force<=0.094)=[];
%%%%%%%%%%% EXP0 %%%%%%%%%%%%%%%%%%%%%
disp(size(force))
disp(size(depth));
force = force(12430:end-1);
force = (force+0.42);

depth = depth(12430:end)*100-9.4;

B = force >= 0;
depth = depth(B);
force = force(B);
plot(force);
hold on;  

%plot(depth);
disp(size(force))
disp(size(depth));

%%%%%%%%%%%%%EXP1%%%%%%%%%%%%%%%%%%%%%%%

%plot(force(1:end),'.');
hold on;  
% depth = depth(1:end)*100-9.84;
% force = (force+0.49);

% B = depth >= 0.0755;
% depth = depth(B);
% force = force(B);
% plot(force(1:end));
% plot(depth(1:end));
% disp(size(force(20:end)));
% disp(size(depth(20:end-16)));

% csvwrite('/Users/sunnysingh/Desktop/HarVi/curr_work/CSV/April17/final_sample_orig_200poke_depth_exp1.csv',depth(20:end-16))
% csvwrite('/Users/sunnysingh/Desktop/HarVi/curr_work/CSV/April17/final_sample_orig_200poke_force_exp1.csv',force(20:end))



% 
% plot(force(1:end,:),depth(1:end-5,:),'.');
% disp(size(depth(1:end-5,:)))
% disp(size(force))