This directory contains files to build and install the python interfaces
to the functions of V%VERSION% SPAMS library.

This version is compatible with python2.7 and python3.x

The interface consists of 4 files : spams.py myscipy_rand.py spams_wrap.py _spams_wrap.so
Note: myscipy_rand.py supplies a random generator for sparse matrix
      for some old scipy distributions
WARNING : the API of spams.OMP and spams.OMPMask has changed since version V2.2

########################################
Installation from PyPI:

The standard installation uses the BLAS and LAPACK libraries used by Numpy:
```bash
pip install spams ## or pip3 for Python3
```

To install the version of SPAMS designed for the MKL Intel library, you can do:
```bash
pip install spams_mkl ## or pip3 for Python3
```

On MacOS, you may have to use:
```bash
env CC=/usr/local/bin/gcc-5 CXX=/usr/local/bin/g++-5 pip install spams ## or pip3 for Python3
```

########################################
Interface building and installation from sources

Packages required: numpy, scipy, six, blas + lapack (preferably from atlas).

For python 2.7:
```bash
tar zxf spams-python-%FULLVERSION%.tar.gz
cd spams-%VERSION%
python2 setup.py build

inst=<your-python-install-dir>
python2 setup.py install --prefix=$inst
```

For python 3.x:
```bash
tar zxf spams-python-%FULLVERSION%.tar.gz
cd spams-%VERSION%
python3 setup.py build

inst=<your-python-install-dir>
python3 setup.py install --prefix=$inst
```

Two documentations are installed in $inst/doc
  - doc_spams.pdf and html/index.html : the detailed user documentation
  - sphinx/index.html : the documentation of python function extracted by sphinx

################################
Linux: tested on Ubuntu 16.04 with python2.7.12 and python3.5.2
    carefully install atlas. For example on my ubuntu I had to do
    apt-get install libatlas-dev libatlas3gf-base libatlas-3gf.so
    If you don't have libblas.so and liblapack.so in /lib or /usr/lib,
    you need to edit setup.py

MacOS: tested on MacOS 10.9.5

```bash
pip install numpy ## or 'pip3'
pip install scipy ## or 'pip3'

brew install clang-omp
brew reinstall gcc --without-multilib

## replace <version> by your gcc version
export CC=/usr/local/bin/gcc-<version>
export CXX=/usr/local/bin/g++-<version>
```

Windows 32bits:
	TODO

Windows 64bits :
	TODO

########################################
Testing the interface :

* Linux or Mac :

For python2.7:
```bash
PYV=`python2 -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";` # get python current version
export PYTHONPATH=$inst/lib/python${PYV}/site-packages
cd $inst/test
python2 test_spams.py -h # to get help
python2 test_spams.py  # will run all the tests
python2 test_spams.py linalg # test of linalg functions
python2 test_spams.py <name1> <name2> ... # run named tests
```

For python3.x:
```bash
PYV=`python3 -c "import sys;t='{v[0]}.{v[1]}'.format(v=list(sys.version_info[:2]));sys.stdout.write(t)";` # get python current version
export PYTHONPATH=$inst/lib/python${PYV}/site-packages
cd $inst/test
python3 test_spams.py -h # to get help
python3 test_spams.py  # will run all the tests
python3 test_spams.py linalg # test of linalg functions
python3 test_spams.py <name1> <name2> ... # run named tests
```

* Windows (binary install) :
  TODO

########################################
Using the interface :
setup your PYTHONPATH (c.f. previously)

```python
import spams
```

The spams functions accept only numpy dense vectors or "Fortran" matrices and
scipy sparce matrices of csc type.

Examples:

```python
import numpy as np
import spams
X = np.asfortranarray(np.random.random((64,200)))
Y = np.asfortranarray(np.random.random((200,20000)))
Z = spams.CalcXY(X,Y)
```
-----
```python
import numpy as np
import scipy
import scipy.sparse
import spams

if not ('rand' in scipy.sparse.__dict__):
    import myscipy as ssp
else:
    import scipy.sparse as ssp
    m=200; n = 200000; d= 0.05
    A = ssp.rand(m,n,density=d,format='csc',dtype=np.float64)
    B = spams.CalcAAt(A)
```
