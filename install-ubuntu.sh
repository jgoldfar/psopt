# Script for Ubuntu 14.04 in Vagrant/Virtualbox
# Install miscellaneous libraries
# Download and install Ipopt, Metis and Mumps
dloaddir=/home/vagrant/dloads
depdir=/home/vagrant/deps
mkdir -p $dloaddir
mkdir -p $depdir
cd $dloaddir
wget --continue http://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.3.tgz
cd $depdir
tar xzvf $dloaddir/Ipopt-3.12.3.tgz
cd $depdir/Ipopt-3.12.3/ThirdParty/Metis
./get.Metis
cd $depdir/Ipopt-3.12.3/ThirdParty/Mumps
./get.Mumps
cd $depdir/Ipopt-3.12.3
./configure --enable-static --enable-shared coin_skip_warn_cxxflags=yes --prefix=$depdir/usr
make -j
make install
# Download and install ADOLC and ColPack
cd $dloaddir
wget --continue www.coin-or.org/download/source/ADOL-C/ADOL-C-2.5.2.tgz
cd $depdir
tar zxvf $dloaddir/ADOL-C-2.5.2.tgz
cd $depdir/ADOL-C-2.5.2
mkdir ./ThirdParty
cd ./ThirdParty
wget --continue http://cscapes.cs.purdue.edu/download/ColPack/ColPack-1.0.9.tar.gz
tar zxvf ColPack-1.0.9.tar.gz
mv ColPack-1.0.9 ColPack
cd ColPack
./configure --prefix=$depdir/usr
make
sudo make install
sudo cp /usr/local/lib/libCol* /usr/lib
cd $HOME/ADOL-C-2.5.2
./configure --enable-sparse --with-colpack=$HOME/ADOL-C-2.5.2/ThirdParty/ColPack --prefix=$depdir/usr
make
make install
sudo cp $HOME/adolc_base/lib64/*.a /usr/lib
sudo cp -r $HOME/adolc_base/include/* /usr/include/
# Download and install PDFlib
cd $HOME/Downloads
wget --continue http://www.pdflib.com/binaries/PDFlib/705/PDFlib-Lite-7.0.5p3.tar.gz
tar zxvf PDFlib-Lite-7.0.5p3.tar.gz
cd PDFlib-Lite-7.0.5p3 
./configure --prefix=$depdir/usr
make
sudo make install
sudo ldconfig

# Download and extract PSOPT
cd $dloaddir
wget --continue https://github.com/PSOPT/psopt/archive/master.zip
unzip master.zip -d /home/vagrant/psopt-master
cd $HOME/psopt-master
# Download and extract SuiteSparse
wget --continue http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.4.3.tar.gz
tar zxvf SuiteSparse-4.4.3.tar.gz
cd $HOME/psopt-master
# Download and extract LUSOL
wget --continue http://www.stanford.edu/group/SOL/software/lusol/lusol.zip
unzip lusol.zip
cd $HOME/psopt-master
# Compile SuiteSparse, LUSOL, dmatrix and PSOPT
make all
echo 'PSOPT installation script completed'
echo 'PSOPT installed in $HOME\psopt-master'
