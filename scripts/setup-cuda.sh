#!/bin/bash
# Copyright (c) Facebook, Inc. and its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

SCRIPTDIR=$(dirname "$0")
source $SCRIPTDIR/setup-helper-functions.sh

# Propagate errors and improve debugging.
set -eufx -o pipefail

function install_cuda_deps {
   # /etc/os-release is a standard way to query various distribution
   # information and is available everywhere
   LINUX_DISTRIBUTION=$(. /etc/os-release && echo ${ID})
   if [[ "$LINUX_DISTRIBUTION" == "ubuntu" || "$LINUX_DISTRIBUTION" == "debian" ]]; then
      apt update -y
      apt install -y cuda-minimal-build-12-8 cuda-nvrtc-dev-12-8
   else # Assume Rocky/CentOS/Fedora/RHEL-like
      dnf -y install cuda-minimal-build-12-8 cuda-nvrtc-devel-12-8
   fi
}

install_cuda_deps

_ret=$?
if [ $_ret -eq 0 ] ; then
   echo "CUDA dependencies installed!"
fi
