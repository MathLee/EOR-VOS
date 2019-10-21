function  Measure_DAVIS_github(save_dir)
osvos_root = fileparts(which(mfilename));
cd(osvos_root);
display(['Starting calculate mIoU!!!']);
names = importdata('src/gt_sets/DAVIS_val_categories.txt');
sumIoU=0.0;
 
  for ii=1:length(names)
        display(['Processing ' num2str(ii)]);
        name = names{ii};%name is the name of the video
                   
        gt_dir = fullfile(osvos_root,'DAVIS','Annotations','480p',name);
        rt_dir = fullfile(save_dir,name);

         names1= dir(fullfile(gt_dir, '*.png')); %name1 is the number of the video
         display(['The frames of the video: ' num2str(length(names1)-2)]);%display  the number of the video
         videosumIoU=0.0;
         
          for iii = 1:length(names1)-2%read every frame of the video
                gt = im2double(imread(fullfile(gt_dir, [num2str(iii,'%05d') '.png'])));
                rt = im2double(imread(fullfile(rt_dir, [num2str(iii,'%05d') '.png'])));

                pointproduct=gt.*rt;
                pointadd=gt+rt;
                I=sum(pointproduct(:));
                U=sum(pointadd(:)>=1);
                IoU=I/U;
                videosumIoU=videosumIoU+IoU;
                
          end 
               ave_IoU = round(videosumIoU/(length(names1)-2)*10000)/10000 ;
               sumIoU=sumIoU+ave_IoU;
               display([ 'This video mIoU: (' name ')       '  num2str( ave_IoU )  ]);
  end
   mIoU= round(sumIoU/length(names)*1000)/1000;
   display(['DAVIS  mIoU:  ' num2str(mIoU) ]);
end

  

      