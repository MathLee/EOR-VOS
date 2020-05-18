function cont_DAVIS_github(save_dir)

display(['Starting Contsnap!!!']);

names = importdata('src/gt_sets/DAVIS_val_categories.txt');

for ii=1:length(names)
    display(['Processing ' num2str(ii)]);
    name = names{ii};
    
    img_dir = fullfile(osvos_root, 'DAVIS', 'JPEGImages','480p',name);
    name1 = dir(fullfile(img_dir, '*.jpg'));
    im = imread(fullfile(img_dir,name1(1).name));
    pred_vid = zeros(size(im,1),size(im,2), length(name1));
    for iii=1:(length(name1)-1)
        result1 = single(im2double(imread(fullfile('/home/lgy/OSVOS-caffe-master_aug/DAVIS/results_sal',name,[num2str(iii-1,'%05d') '.png']))));
        result2 = single(im2double(imread(fullfile('/home/lgy/OSVOS-caffe-master_aug/DAVIS/DAVIS20-cont-png',name,[num2str(iii-1,'%05d') '.png']))));
        pred_vid(:,:,iii) = compute_snap(result1, result2);
    end
    if ~exist(fullfile(save_dir,name),'dir')
        mkdir(fullfile(save_dir,name));
    end
    for jj=1:(size(pred_vid,3)-1)
        imwrite(pred_vid(:,:,jj), fullfile(save_dir,name, [num2str(jj-1,'%05d') '.png']));
    end
    
end
end


function snapped = compute_snap(nb_mask, cont)
% Parameters for snapping
th_ucm = 0.29;
th_mask = 122/255;

% From contours to ucm
ucm = cont2ucm(cont);
sp = ucm2part( ucm, th_ucm );

% Snap the result
snapped = snap(sp,(nb_mask>th_mask)+1)>0;

end
