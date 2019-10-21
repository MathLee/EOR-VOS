#! /usr/bin/env sh
set -e
/home/lgy/OSVOS-caffe-master_2_flow_0403/caffe-osvos/build/tools/caffe train --solver=/home/lgy/OSVOS-caffe-master_2_flow_0403/src/parent/solvers/solver_step1.prototxt  --snapshot=/home/lgy/OSVOS-caffe-master_2_flow_0403/src/parent/osvos_parent_step1_iter_1000.solverstate >& /home/lgy/OSVOS-caffe-master_2_flow_0403/src/parent/logFiles/two_frame_osvos_0405.log &
