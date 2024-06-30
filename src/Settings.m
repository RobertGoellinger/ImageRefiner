classdef Settings
    %SETTINGS Path stubs for the programm are defined here
    
    properties (Constant = true)
        % Version number: please change with every release
        RELEASE_VERSION = '0.9.6';
        
        % LogFileName
        LOG_FILE_NAME = 'ImageRefinerLog.log';
        
        % Used during testing
        IMPORT_PATH = 'C:\git\imagerefiner\data';
        
        % To be used during ImageRefiner Run
        VALID_FILE_NAME_SEPARATOR = '(_|:|-)';
        PATH_PATTERN_TO_CHECK = ['[0-9]{1,5}', Settings.VALID_FILE_NAME_SEPARATOR, '[0-9]{2}'];
        IDENTIFIER_PATTERN_TO_CHECK = ['[0-9]{1,5}', Settings.VALID_FILE_NAME_SEPARATOR, '{0,1}',...
            '[0-9]{0,2}', ... % Intentional!
            '[a-zA-z]{0,2}', Settings.VALID_FILE_NAME_SEPARATOR,...
            '[0-9]{1,3}'];
        
        % User specific fallback options
        DEFAULT_IMAGE_EXTENSION = '.tif';
        DEFAULT_VIDEO_EXTENSION = '.tif';
        DEFAULT_COLUMNS_TO_EXPORT = {'Centroid', 'Area', 'Perimeter', 'MinFeretDiameter'};
        DEFAULT_EXPORT_PATH = 'C:\git\imagerefiner\target';
        DEFAULT_LOGGING_PATH = 'C:\git\imagerefiner\target';
        DEFAULT_EXPORT_FORMAT = 'excel';
        DEFAULT_VERIFICATION_MODE = false;
        DEFAULT_COLOR_CHANNEL = 'CH2';
        DEFAULT_AREA_BOUNDS = [4.7, 100];
        DEFAULT_SCALE_PIXEL_TO_MICROMETER = 0.30120;
        DEFAULT_CONNECTIVITY = 4;
        DEFAULT_PIXEL_SIZE_OF_ARTIFACTS = 15;
        DEFAULT_THRESHOLD_BLACK_WHITE_IMAGE = 50;
        
        % Expected parameter values to check against
        EXPECTED_EXPORT_FORMATS = {'excel', 'json', 'all'};
        EXPECTED_COLOR_CHANNELS = {'CH1', 'CH2', 'CH3', 'CH4'};
        EXPECTED_IMAGE_EXTENSIONS = {'.tif', '.png'};
        EXPECTED_VIDEO_EXTENSIONS = {'.tif', '.png'};
    end
    
    methods (Access = public, Static)
        function exportList = gatherSettings(s)
            %GATHERSETTINGS gathers all contents of the Settings class to
            %be used during debugging.
            dateOfExecution = datetime('now','Format','d-MMM-y HH:mm:ss');
            user = getenv('username');
            exportList = {'Settings used during generation of data', ''; ...
                'Date of execution', dateOfExecution; ...
                'User', user; ...
                'Version', Settings.RELEASE_VERSION; ...
                'Export directory', s.ExportDirectory; ...
                'Import directory', s.ImportDirectory; ...
                'Image extension', s.ImageExtension; ...
                'Video extension', s.VideoExtension; ...
                'Connectivity', s.Connectivity; ...
                'Size of artifacts in Pixels', s.PixelSizeOfArtifacts; ...
                'Conversion factor from pixels to microns', s.ScalePixelToMicrometer;...
                'Minimum cappilary cutoff area', s.AreaBounds(1);...
                'Maximum cappilary cutoff area', s.AreaBounds(2);...
                'Threshold of black white detection', s.ThresholdBlackWhiteImage;
                'Regular Expression Pattern to identify correct folder', Settings.PATH_PATTERN_TO_CHECK;
                'Regular Expression Pattern to identify correct file', s.ColorChannel};
        end
    end
end

