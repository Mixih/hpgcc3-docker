#!/bin/env bash
set -e

# grab and extract necessary files:
wget http://hpgcc3.org/downloads/hpgcc3_R004.revA.tar.gz
tar -xvf hpgcc3_R004.revA.tar.gz -C hpgcc3
wget http://www.hpcalc.org/hp49/pc/rom/hp4950v215.zip
unzip hp4950v215.zip
cp hp4950v215/4950_215.bin /hpgcc3/libs_workspace/make_rom/original_rom/4950_215.bin

# make tools
cd /hpgcc3/tools_workspace
for DEP in */ ; do
  if [[ "$DEP" != "install_tools/" ]] && [[ "$DEP" != "eclipse_plugin_hpgcc3/" ]]; then
    cd "${DEP}Release" && make all && cd ../..
  fi
done
cd install_tools
sed -i s/'${WORKSPACE}'/'\/hpgcc3\/tools_workspace'/g Makefile
sed -i s/'~\/Desktop\/Install_plugin.sh'/'temp'/g Makefile
make all
rm temp

# make libs
export WORKSPACE=/hpgcc3/libs_workspace
cd /hpgcc3/libs_workspace
for DEP in */ ; do
  if [[ "$DEP" != "install_all/" ]] && [[ "$DEP" != "make_rom/" ]]; then
    cd $DEP && make all && cd ..
  fi
done
cd make_rom && make all
cd ../install_all && make all
chmod 777 -R /hpgcc3/bin
chmod 777 /hpgcc3/*

# clean up
cd .. && rm -rf hp4950v215 hp4950v215.zip hpgcc3_R004.revA.tar.gz
