classdef VideoFrameRefinementTask < Tasks.AbstractTask
    % VideoFrameRefinementTask: A Task to segment video files into frames and
    % then run the image refinement process
    %
    % Syntax:
    %   >> videoFrameRefinementTask = Tasks.VideoFrameRefinementTask('C:\\path\to\folder\with\videoData', ... 
    %                               'ExportDirectory', 'C:\\path\to\export\folder', ...
    %                               'ExportFormat', 'excel', ...
    %                               'ColumnsToExport', {'Area', 'Perimeter', 'Centroid'}, ...
    %                               'VerificationMode', false)
    %   >> videoFrameRefinementTask.execute()
    %
    
    properties (Access = public)
        ImportDirectory;    %char - Source directory
        ImageExtension;     %char - Image file format
        VideoExtension;     %char - Video file format
        ExportDirectory;    %char - Directory to export generated results to
        ExportFormatEnum;   %char - Export format
        ColumnsToExport;    %cell - Analysis columns to export: for details see documentation
        VerificationMode;   %logical - Should analysis be performed for all pictures
        ColorChannel;       %char - Select color channel for analysis
        AreaBounds;         %double [1x2] - Upper and lower area bound during image analysis
        ScalePixelToMicrometer %@double - Conversion factor between pixel and micrometer (10^-6 m)
        Connectivity        %@double - Connectivity parameter for image analysis
        PixelSizeOfArtifacts %@double - Artifact size parameter for image analysis
        ThresholdBlackWhiteImage %@double - Threshold parameter used during image analysis
    end 
    
    properties (Access = private)
        SettingsStruct      %@struct - Settings used for analysis as specified during parser call
    end
    
    methods (Access = public)
        function obj = VideoFrameRefinementTask(varargin)
            %Construct an instance of the VideoFrameRefinementTask
            
            p = inputParser();
            addRequired(p, 'ImportDirectory', @(x)validateattributes(x,{'char'},{'nonempty'}));
            addParameter(p, 'ExportDirectory', fullfile(Settings.DEFAULT_EXPORT_PATH), @(x)validateattributes(x,{'char'},{'nonempty'}));
            addParameter(p, 'ExportFormat', Settings.DEFAULT_EXPORT_FORMAT, @(x) any(validatestring(x, Settings.EXPECTED_EXPORT_FORMATS)));
            addParameter(p, 'ColumnsToExport', Settings.DEFAULT_COLUMNS_TO_EXPORT, @(x)validateattributes(x,{'cell'}, {'nonempty'}));
            addParameter(p, 'VerificationMode', Settings.DEFAULT_VERIFICATION_MODE, @(x)validateattributes(x,{'logical'}, {'nonempty'}));
            addParameter(p, 'ColorChannel', Settings.DEFAULT_COLOR_CHANNEL, @(x) any(validatestring(x, Settings.EXPECTED_COLOR_CHANNELS)));
            addParameter(p, 'AreaBounds', Settings.DEFAULT_AREA_BOUNDS , @(x) validateattributes(x, {'double'},{'nondecreasing'}));
            addParameter(p, 'ScalePixelToMicrometer', Settings.DEFAULT_SCALE_PIXEL_TO_MICROMETER, @(x) validateattributes(x, {'double'},{'positive'}));
            addParameter(p, 'ImageExtension', Settings.DEFAULT_IMAGE_EXTENSION, @(x) any(validatestring(x, Settings.EXPECTED_IMAGE_EXTENSIONS)));
            addParameter(p, 'VideoExtension', Settings.DEFAULT_VIDEO_EXTENSION, @(x) any(validatestring(x, Settings.EXPECTED_VIDEO_EXTENSIONS)));
            addParameter(p, 'Connectivity', Settings.DEFAULT_CONNECTIVITY, @(x) validateattributes(x, {'double'},{'positive'}));
            addParameter(p, 'PixelSizeOfArtifacts', Settings.DEFAULT_PIXEL_SIZE_OF_ARTIFACTS, @(x)validateattributes(x, {'double'}, {'positive'}));
            addParameter(p, 'ThresholdBlackWhiteImage', Settings.DEFAULT_THRESHOLD_BLACK_WHITE_IMAGE, @(x)validateattributes(x, {'double'}, {'positive'}));
            
            parse(p, varargin{:});
            
            obj.SettingsStruct = p.Results;
            
            obj.ImportDirectory = p.Results.ImportDirectory;
            obj.ExportDirectory = p.Results.ExportDirectory;
            obj.ExportFormatEnum = Enum.ExportFormatEnum.classify(p.Results.ExportFormat);
            obj.ColumnsToExport = p.Results.ColumnsToExport;
            obj.VerificationMode = p.Results.VerificationMode;
            obj.ColorChannel = Enum.ColorChannelEnum.classify(p.Results.ColorChannel);
            obj.AreaBounds = p.Results.AreaBounds;
            obj.ScalePixelToMicrometer = p.Results.ScalePixelToMicrometer;
            obj.Connectivity = p.Results.Connectivity;
            obj.ImageExtension = p.Results.ImageExtension;
            obj.PixelSizeOfArtifacts =  p.Results.PixelSizeOfArtifacts;
            obj.ThresholdBlackWhiteImage = p.Results.ThresholdBlackWhiteImage;
        end
        
        function status = execute(obj)
            % run the Video Preprocessing & Image Refinement process
            logger = Logging.Logger();
            logger.writeLogo();
            logger.writeVersion();
            try
                status = 1;
                videoFrameSplitter = VideoHandler.VideoFrameSplitter(obj.ImportDirectory, obj.VideoExtension);
                videoFrameSplitter.execute();
                
                directoryCrawler = ImageHandler.DirectoryCrawler(obj.ImportDirectory,...
                    obj.ColorChannel, obj.ImageExtension, obj.PixelSizeOfArtifacts, obj.ThresholdBlackWhiteImage);
                directoryCrawler.execute();
                
                imageAnalyzer = ImageHandler.ImageAnalyzer(directoryCrawler.ImageDtoCollection, obj.Connectivity, obj.AreaBounds, obj.ScalePixelToMicrometer);
                imageAnalyzer.execute();
                
                if obj.VerificationMode
                    imageVerifier = ImageHandler.ImageVerifier(imageAnalyzer.ImageDtoCollection, obj.ExportDirectory);
                    imageVerifier.execute();
                end
                
                settingsStruct = obj.SettingsStruct;
                switch obj.ExportFormatEnum
                    case Enum.ExportFormatEnum.EXCEL
                        excelExporter = Export.ExcelExporter(obj.ExportDirectory,...
                            imageAnalyzer.ImageDtoCollection, imageAnalyzer.SummaryCollection, obj.ColumnsToExport, settingsStruct);
                        excelExporter.execute();
                    case Enum.ExportFormatEnum.JSON
                        jsonExporter = Export.JsonExporter(obj.ExportDirectory, ...
                            imageAnalyzer.ImageDtoCollection, imageAnalyzer.SummaryCollection, obj.ColumnsToExport, settingsStruct);
                        jsonExporter.execute();
                    case Enum.ExportFormatEnum.ALL
                        excelExporter = Export.ExcelExporter(obj.ExportDirectory,...
                            imageAnalyzer.ImageDtoCollection, imageAnalyzer.SummaryCollection, obj.ColumnsToExport, settingsStruct);
                        jsonExporter = Export.JsonExporter(obj.ExportDirectory, ...
                            imageAnalyzer.ImageDtoCollection, imageAnalyzer.SummaryCollection, obj.ColumnsToExport, settingsStruct);
                        excelExporter.execute();
                        jsonExporter.execute();
                    case Enum.ExportFormatEnum.NOT_CLASSIFIED
                        logger.warn('Enum.ExportFormatEnum', 'no correct export format selected! Please check task call!');
                    otherwise 
                        logger.warn('Enum.ExportFormatEnum', 'Failed');
                end
                logger.info('ImageRefinerTask', 'Succesfull execution of ImageRefinerTask!')
            catch exception
                status = 0;
                logger.warn('ImageRefinerTask', exception.getReport())
            end
        end
    end
end

