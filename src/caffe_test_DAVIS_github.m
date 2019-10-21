function [pred_vid, vid] = caffe_test_DAVIS_github(osvos_params)
caffe.reset_all();
osvos_params.test_net = caffe.Net(osvos_params.test_model, osvos_params.test_weights, 'test');

if isfield(osvos_params, 'cont_weights')
    osvos_params.test_net.copy_from(osvos_params.cont_weights);
end
img_dir = fullfile(osvos_root, 'DAVIS', 'JPEGImages', '480p', osvos_params.name);
names = dir(fullfile(img_dir, '*.jpg'));

im = imread(fullfile(img_dir,names(1).name));
pred_vid = zeros(size(im,1),size(im,2), length(names),2);
for ii=1:length(names)
    display(['Processing frame ' num2str(ii) ' out of ' num2str(length(names))]);
    im = imread(fullfile(img_dir,names(ii).name));
    vid{ii} = im;
    tic;
    result = caffe_score(osvos_params.test_net, im);
    res_1= result{1};
    pred_vid(:,:,ii,1) = res_1;
    toc;
end

end


function pred = caffe_score(net, data)
data = single(data);
mval = [122.67892 116.66877 104.00699];
dim = size(data);

% Mean substraction
for ch=1:dim(3)
    data(:,:,ch) = data(:,:,ch) - mval(ch);
end

% BGR format
data = data(:,:,[3 2 1]);

% Permute width and height (Caffe thing)
data = permute(data, [2, 1, 3]);
net.blobs('data').reshape([size(data) 1]);
res = net.forward({data});
for i=1:length(res)
    pred{i} = permute(res{i},[2 1]);
end
end

