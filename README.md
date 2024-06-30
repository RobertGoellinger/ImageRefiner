# ImageRefiner
Image Refinement for medical images using MATLAB

## Aim of this software
This software was written to improve the MATLAB script published in "Gli1+ Pericyte Loss Induces Capillary Rarefaction and
Proximal Tubular Injury" by Rafael Kramann et al. 

## Set up Guide
1. Clone Git-Repository to a place of your choosing on your hard drive
2. Change Variables `IMPORT_PATH` and `EXPORT_PATH` to the appropriate values for your setup inside `Settings.m`  
3. Inside MATLAB add repository folder to path (with subfolders)
4. The ImageRefiner requires a file `ImageRefinerLog.log` inside the folder `target` in the ImageRefiner base folder in order to log Messages and programm messages used for debugging. 

## Working with ImageRefiner
1. create a instance of the ImageRefiner: `imageRefinerTask = Tasks.ImageRefinerTask('C:\\path\to\folder\with\data', 'ExportDirectory', 'C:\\path\to\export\folder', 'ExportFormat', 'excel', 'ColumnsToExport', {'Area', 'Perimeter', 'Centroid'}, 'VerificationMode', false)`
Please make sure to replace the folder paths to fit your local setup. You can omit or add all the name value pairs in the call to `Task.ImageRefinerTask`. 
2. run the refinement process: `imageRefinerTask.execute()`

Please use the task to run the image refinement process instead of directly calling the different parts of the refiner as the task also includes functionality to export the generated results.  

A full list of supported Settings which may be used during the analysis process are shown below: 

| Parameters                | Description                                         | Type    | Default Value                                         |
| :-----------------------: | :-------------------------------------------------: | :-----: | :----------------------------------------------------:|
| ImportDirectory           | Path where data is located                          | char    | none                                                  |
| ImageExtension            | Image Extension - please add '.'                    | char    | '.tif'                                                |
| ExportDirectory           | Path to directory where exports should export to    | char    | target directory in git repository                    |
| ExportFormat              | what format should the exports have                 | char    | 'excel'                                               |
| ColumnsToExport           | which columns need to be included in export         | cell    | {'Centroid', 'Area', 'Perimeter', 'MinFeretDiameter'} | 
| VerificationMode          | perform verification on all images in directory     | logical | false                                                 |
| ColorChannel              | Ending of split color channels                      | char    | 'CH2'                                                 |
| AreaBound                 | Upper/lower limit of the detected areas [10^-6 m^2] | double  | [4.7, 100]                                            |
| Connectivity              | Connectivity parameter for analysis                 | double  | 8                                                     |
| PixelSizeOfArtifacts      | Pixel size used to identify artifacts               | double  | 15                                                    |   
| ThresholdBlackWhiteImage  | Threshold for black/white images                    | double  | 50                                                    |


## Data
The supplied data needs to adhere to this scheme: 

```  
  data
  |----191_19
  |       |----Cortex
  |       |       |----191-19_GF01
  |       |       |       |-----<Name>_CH1.tif
  |       |       |       |-----<Name>_CH2.tif
  |       |       |       |-----<Name>_CH3.tif
  |       |       |       |-----<Name>_CH4.tif
  |       |       |----191-19_GF02
  |       |       |       |-----<Name>_CH1.tif
  |       |       |       |-----<Name>_CH2.tif
  |       |       |       |-----<Name>_CH3.tif
  |       |       |       |-----<Name>_CH4.tif
  |       |----Medulla
  |       |       |----191-19_GF01
  |       |       |       |-----<Name>_CH1.tif
  |       |       |       |-----<Name>_CH2.tif
  |       |       |       |-----<Name>_CH3.tif
  |       |       |       |-----<Name>_CH4.tif
  ...
```

If you do not stick to this scheme the code will not work correctly!

## Developer
Developed by Robert Goellinger, RWTH Aachen University. Issues or requests can be submitted by email to `robert.goellinger@rwth-aachen.de`. Please make sure to include your log-file for analysis of the underlying problems.

## Cite as: 
Robert Goellinger (2021), ImageRefiner - A Matlab Toolbox for refining nephrological images, RWTH Aachen University

## Resources
1.  Luke Winslow (2021). log4m - A powerful and simple logger for matlab (https://www.mathworks.com/matlabcentral/fileexchange/37701-log4m-a-powerful-and-simple-logger-for-matlab), MATLAB Central File Exchange. Retrieved January 7, 2021. 
2. Gamma, Helm, Johnson & Vlissides (1994). Design Patterns published by Addison Wesley
3. "Gli1+ Pericyte Loss Induces Capillary Rarefaction and Proximal Tubular Injury" by Rafael Kramann et al. 