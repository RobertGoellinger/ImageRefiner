%% Setup 
clc
close
clear

%% Loading the image to MATLAB Workspace
folderName = uigetdir; %Prompts user to select folder 
fileName = uigetfile([folderName, '\', '*.png']); %Prompts user to select file to be analyzed
% WTF how does this even work?
uiimport = (fileName); %Imports selected file name
originalImage = imread(fileName); %Reads imported file

%% Image Treatment
morphologicalObj= strel('disk', 15); 
% Detect background noise
background = imopen(originalImage, morphologicalObj);

% Show original image
figure 
surf(double(background(1:8:end,1:8:end))),zlim([0 255]);
set(gca,'ydir','reverse');

% Remove noise from Image
filteredImage = originalImage - background;
% imshow(filteredImage);
level = graythresh(filteredImage);
blackWhiteImage = im2bw(filteredImage, level);

% Removes all Artifacts with area smaller than threshold pixels
% Threshold number of pixels needs to be optimized depending on image
% quality
tresholdNumberPixels = 50; 
blackWhiteImage = bwareaopen(blackWhiteImage, thresholdNumberPixels);

% connectivity needs to be optimized
% Pixels are connected if their edges touch. Two adjoining pixels are part 
%of the same object if they are both on and are connected along the horizontal 
% or vertical direction.
connectivity = 4; 
connectedComponents = bwconncomp(blackWhiteImage, connectivity);
connectedComponents.NumObjects;
labeled = labelmatrix(connectedComponents);
whos labeled; 
% Why?
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle'); %colors individual capillaries 
figure, imshow(RGB_label);
capillarydata = regionprops(connectedComponents,'all'); %reads all perimeter data of the capillaries
capillary_peri = [capillarydata.Perimeter];
capillary_area = [capillarydata.Area];
[min_perim, idx] = min(capillary_peri);                                                                                                        
capillary = false(size(blackWhiteImage));            
capillary(connectedComponents.PixelIdxList{idx}) = true;
%Converts perimeter data to micrometers

PDataInMicrons =capillary_peri*0.30120'; % Why multiply by this number?
%Converts Area data to Micrometers
ADataInMicrons =capillary_area*0.0907'; % Why multiply by this number? 
%while loop: look at each point, it it is greater than 10, put in into new vector
for index = 1:1:length(ADataInMicrons)
 if ADataInMicrons(index) > 4.9 && ADataInMicrons(index) < 100
   AreaToExport(index) = ADataInMicrons(index);
 end
end

% Why nbins?
nbins = 50;
%% Plotting Results
%Generates capillary Area histogram
figure
hist(AreaToExport, nbins) 
title('Histogram of Capillary Area Data')
%Generates capillary Perimeter histogram
figure
hist(PDataInMicrons, nbins) 
title('Histogram of Capillary Perimeter Data')

%% Export Data to Excel Sheet
% Is Excel file necessary?
% Additional steps in process?

SA = AreaToExport';
SP = PDataInMicrons';
csvwrite('AreaQuant1.csv', SA) %Writes data to area excel sheet
csvwrite('PerimQuant1.csv', SP) %Writes data to perimeter excel sheet
