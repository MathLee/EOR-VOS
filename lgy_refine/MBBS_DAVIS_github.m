function MBBS_DAVIS_github(save_dir)
display(['Starting MBBS!!!']);
names = importdata('/home/lgy/OSVOS-caffe-master_deeplab/src/gt_sets/DAVIS_val_categories.txt');%DAVIS_val_categories  train_categories
for ii=1:length(names)
       name = names{ii};
       cont_dir = fullfile('/home/lgy/OSVOS-caffe-master_aug/DAVIS/cont_flojpg', name); 
       osvos_dir = fullfile('/home/lgy/OSVOS-caffe-master_aug/DAVIS/results_cont',name); 
        if ~exist(fullfile(save_dir,name),'dir')
             mkdir(fullfile(save_dir,name));
        end
       name_list = dir(fullfile(cont_dir, '*.png')); 
       display(['Processing ' num2str(ii)  '  Length ' num2str(length(name_list))]);%display  the number of the video
       
       for iii=1:length(name_list)
           im = im2double(imread(fullfile(cont_dir,[num2str(iii-1,'%05d') '.png'])));
           threshold = graythresh(im);        
           bw =( im>threshold);
          bw = imdilate(bw,strel('disk',5));
          osvosres = imread(fullfile(osvos_dir,[num2str(iii-1,'%05d') '.png']));
          osvosres = (osvosres>0);
          osvos_res = osvosres.*bw;
           [height_all,weight_all] = find(osvos_res==1);
           height_max = max(height_all);
           height_min = min(height_all);
           weight_max = max(weight_all);
           weight_min = min(weight_all);
           bbox = zeros(size(osvos_res));
           bbox(height_min:height_max,weight_min:weight_max) = 1;
           osvos_bbox = osvosres.*bbox;%seed
           bbox_sum = sum(sum(bbox));
           if bbox_sum == 0
                imwrite(osvosres,fullfile(save_dir,name,[num2str(iii-1,'%05d') '.png']));
           else
               [height_all,weight_all] = find(osvos_bbox==1);
                seednum = length(height_all);
                station = zeros(1,seednum);
                break_num = 0;
               osvos_seed_grow = seedgrow(osvosres,osvos_bbox,height_all,weight_all,station,break_num);
               imwrite(osvos_seed_grow,fullfile(save_dir,name,[num2str(iii-1,'%05d') '.png']));
           end
       end
end
end





