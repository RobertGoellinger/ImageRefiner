Setting your computer up to run the ImageRefiner
================================================

Setting up MATLAB
-----------------

Download MATLAB from the maintainer `MathWorks <https://de.mathworks.com/>`_.
  * Follow the instructions during account creation and registration.  
  * Make sure to use your RWTH email address (firstName.lastName@rwth-aachen.de) to get access to the campus licence.
  * Make sure to add the following toolboxes: 
    - ImageProcessing Toolbox
  
In case of problems refer to this :download:`presentation <source/InstallationMATLAB.pdf>`.
If you need a short introduction to MATLAB please feel free to contact the `fIT-Team of the IT Center RWTH Aachen <https://www.itc.rwth-aachen.de/go/id/eyhv>`_.


Installing git (for developers only)
------------------------------------

Git is a version control software used in nearly all major software development companies. It can be downloaded `here <https://git-scm.com/>`. 

The project is hosted on a RWTH internal `gitlab instance <https://git.rwth-aachen.de/>`. 
Please use your RWTH credentials to access the code base and contact the lead developer to be added to the project. 


Installing Bazel (for developers only)
--------------------------------------

`Bazel <https://www.bazel.build/>`_ is a build language loosely based on the Python syntax called Starlark. 
Make sure to download the wrapper `bazelisk <https://github.com/bazelbuild/bazelisk>`_ to make sure you are always running the correct version of Bazel.


Setting up the ImageRefiner
---------------------------

Please follow these instructions:
  * Clone Git-Repository to a place of your choosing on your hard drive (You may also use a .zip-File -> unzip first)
  * Change Variables `IMPORT_PATH` and `EXPORT_PATH` to the appropriate values for your setup inside :file:`Settings.m`  
  * Inside MATLAB add repository folder to path (with subfolders)
  * The ImageRefiner requires a file `ImageRefinerLog.log` inside the folder `target` in the ImageRefiner base folder in order to log Messages and programm messages used for debugging. 