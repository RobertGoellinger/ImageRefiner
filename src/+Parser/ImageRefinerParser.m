classdef ImageRefinerParser < handle
   %IMAGEREFINERPARSER - Custom Parser for ImageRefinerTask 
   
   methods (Access = public)
       function obj = ImageRefinerParser()
            obj = inputParser();
            addRequired(obj, 'ImportDirectory', @(x)validateattributes(x,{'char'},{'nonempty'}));
            addParameter(obj, 'ExportDirectory', fullfile(Settings.DEFAULT_EXPORT_PATH), @(x)validateattributes(x,{'char'},{'nonempty'}));
            addParameter(obj, 'ExportFormat', Settings.DEFAULT_EXPORT_FORMAT, @(x) any(validatestring(x, Settings.EXPECTED_EXPORT_FORMATS)));
            addParameter(obj, 'ColumnsToExport', Settings.DEFAULT_COLUMNS_TO_EXPORT, @(x)validateattributes(x,{'cell'}, {'nonempty'}));
            addParameter(obj, 'VerificationMode', Settings.DEFAULT_VERIFICATION_MODE, @(x)validateattributes(x,{'logical'}, {'nonempty'}));
            addParameter(obj, 'ColorChannel', Settings.DEFAULT_COLOR_CHANNEL, @(x) any(validatestring(x, Settings.EXPECTED_COLOR_CHANNELS)));
            addParameter(obj, 'AreaBounds', Settings.DEFAULT_AREA_BOUNDS , @(x) validateattributes(x, {'double'},{'nondecreasing'}));
            addParameter(obj, 'ScalePixelToMicrometer', Settings.DEFAULT_SCALE_PIXEL_TO_MICROMETER, @(x) validateattributes(x, {'double'},{'positive'}));
            addParameter(obj, 'ImageExtension', Settings.DEFAULT_IMAGE_EXTENSION, @(x) any(validatestring(x, Settings.EXPECTED_IMAGE_EXTENSIONS)));
            addParameter(obj, 'Connectivity', Settings.DEFAULT_CONNECTIVITY, @(x) validateattributes(x, {'double'},{'positive'}));
            addParameter(obj, 'PixelSizeOfArtifacts', Settings.DEFAULT_PIXEL_SIZE_OF_ARTIFACTS, @(x)validateattributes(x, {'double'}, {'positive'}));
            addParameter(obj, 'ThresholdBlackWhiteImage', Settings.DEFAULT_THRESHOLD_BLACK_WHITE_IMAGE, @(x)validateattributes(x, {'double'}, {'positive'}));
       end
   end
    
end