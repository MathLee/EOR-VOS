# EOR-VOS
   This project provides the code and results for 'Effective Online Refinement for Video Object Segmentation', MTAP 2019. [Paper link](http://link.springer.com/article/10.1007/s11042-019-08146-3).
   Our code is implemented based on the OSVOS in Caffe. You can first install the 'caffe-osvos' according to the [OSVOS](https://github.com/kmaninis/OSVOS-caffe). 

# Results
   We provide the one result of our 4 runs results here: [DAVIS Result](https://pan.baidu.com/s/1lVx-DeX-HOFynDNe70YDYg&shfl=sharepset) and [Youtube Results](https://pan.baidu.com/s/1JFikjH9DxxzsMW0lkJYC9g&shfl=sharepset).
     
# DAVIS_20 Testing
1. Download the 20 trained model from [here](https://pan.baidu.com/s/12CsQVstDL1qSj1l2E3sCWQ&shfl=sharepset) (1.2 G) and put it under `models/DAVIS_github/`.
2. Edit in file `set_params_DAVIS_github.m` the parameters of the code (eg. useGPU, gpu_id, etc.).
3. Run `test_DAVIS_github.m`.

# Citation
        @ARTICLE{Li_2019_MTAP,
                author = {Li, Gongyang and Liu, Zhi and Zhou, Xiaofei},
                title = {Effective Online Refinement for Video Object Segmentatio},
                journal = Multimedia Tools and Applications,
                doi = '10.1007/s11042-019-08146-3',
                year = {2019}}


If you encounter any problems with the code, want to report bugs, etc.
Please contact me at lllmiemie@163.com or ligongyang@shu.edu.cn.
