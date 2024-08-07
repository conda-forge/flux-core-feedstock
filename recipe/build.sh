#!/bin/bash
# Build 
export CPPFLAGS="-D_FORTIFY_SOURCE=2 -O2 -isystem $PREFIX/include"
./configure --prefix=${PREFIX}
make

# Tests 
if [ "${mpi}" == "openmpi" ]; then
  export OMPI_MCA_btl=self,tcp
fi

# Do not test on Arch
if [[ -z "${CONDA_BUILD_CROSS_COMPILATION}" ]]; then
  make check
fi

# Install 
make install
