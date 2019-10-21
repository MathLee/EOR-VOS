clear; close all; clc;
addpath(genpath('src'));
addpath(genpath('lib'));
addpath(genpath('lgy_refine'));
addpath(genpath('mIoU'));

cd(osvos_root);

save_sal_dir = '/home/lgy/OSVOS-caffe-master_aug/DAVIS/results_sal';
save_cont_dir = '/home/lgy/OSVOS-caffe-master_aug/DAVIS/results_cont';
save_final_dir = '/home/lgy/OSVOS-caffe-master_aug/DAVIS/results_final';
names = importdata('src/gt_sets/DAVIS_val_categories.txt');


for ii=1:length(names)
       name = names{ii};
       set_params_DAVIS_github(name);
       [pred, vid] = caffe_test_DAVIS_github(osvos_params);
       if ~exist(fullfile(save_sal_dir,name),'dir')
             mkdir(fullfile(save_sal_dir,name));
       end
       for jj=1:size(pred,3)
             imwrite(pred(:,:,jj,1), fullfile(save_sal_dir,name, [num2str(jj-1,'%05d') '.png']));
       end
end
cont_DAVIS_github(save_cont_dir);
MBBS_DAVIS_github(save_final_dir);
Measure_DAVIS_github(save_final_dir);


