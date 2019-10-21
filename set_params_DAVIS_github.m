function osvos_params = set_params_DAVIS_T(name)

if evalin('base','exist(''osvos_params'',''var'')')
    if evalin('base','strcmp(osvos_params.name,name)')
        % Recover the parameters
        osvos_params = evalin('base', 'osvos_params');
        return;
    end
end

disp('Setting OSVOS parameters')

%% ATTENTION: Parameters to be modifed by the user

% Specify /path/to/caffe/matlab (no need to change if didn't move caffe-osvos)
osvos_params.caffe_path = './caffe-osvos/matlab/';

% For CPU mode, set to 0 (WARNING: 0 is slow)
osvos_params.useGPU = 1;

% Set the ID of your GPU (default 0)
osvos_params.gpu_id = 1;

% Train online or use pre-trained model?(1=Yes,0=No)
osvos_params.useTrainOnline = 1;

%% Other parameters
osvos_params.name = name;

if ~exist(osvos_params.caffe_path,'dir')
    error(['Caffe path ''' osvos_params.caffe_path ''' not found'])
end

addpath(osvos_params.caffe_path);
caffe.reset_all();

% Network  test model and weights
osvos_params.test_model = fullfile(osvos_root,'models','deploy.prototxt');
 osvos_params.test_weights = fullfile(osvos_root,'models/DAVIS_github',[name '.caffemodel']);

% Copy to base workspace
assignin('base', 'osvos_params', osvos_params);

% For GPU users
if osvos_params.useGPU
    evalin('base', 'caffe.set_mode_gpu()');
    evalin('base', 'caffe.set_device(osvos_params.gpu_id)')
end

end
