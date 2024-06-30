classdef ImageVerifier < ImageHandler.AbstractImageHandler
    %ImageVerifier: Mark all areas of interest and display them to the user
    
    properties(Access = public)
        ImageDtoCollection;         %@cell of DTO.ImageDto
        ExportMode                  %@logical
        ExportDirectory             %@char
    end
    
    methods (Access = public)
        function obj = ImageVerifier(imageDtoCollection, exportDirectory)
            %Constructor for an ImageVerifier instance
            if nargin < 1 || ~isa(imageDtoCollection, 'cell')
                throw(Exception.ArgumentException('imageDtoCollection', 'cell'))
            end
            
            if nargin < 2
                obj.ExportMode = false;
            else
                obj.ExportMode = true;
            end
            
            if nargin > 2 || ~isa(exportDirectory, 'char')
                throw(Exception.ArgumentException('exportDirectory', 'char'))
            end
            
            obj.ImageDtoCollection = imageDtoCollection;
            obj.ExportDirectory = exportDirectory;
        end
        
        function execute(obj)
            imageDtoCollection = obj.ImageDtoCollection;
            if isempty(imageDtoCollection)
                throw(Exception.LogicalErrorException('imageDtoCollection', 'should not be empty. Possibly image names are not correct!'))
            end
            
            logger = Logging.Logger();
            logger.startMessage('ImageVerifier','Image Verification Process')
            
            for indexDto = 1:length(imageDtoCollection)
                logger.progressMessage('ImageVerifier', indexDto, length(obj.ImageDtoCollection))
                obj.verifyImageDto(obj.ImageDtoCollection{indexDto});
                logger.info('ImageAnalyzer:VerificationMode', 'Please press any key to analyse the next picture.');
                pause;
            end
            
            logger.finishedMessage('ImageVerifier','Image Verification Process')
        end
    end
    
    methods (Access = private)
        function verifyImageDto(obj, imageDto)
            bwLabeledData = labelmatrix(imageDto.ConnectedComponents);
            rgbLabeledData = label2rgb(bwLabeledData, @spring, 'c', 'shuffle');
            
            figure('Name', ['Verification of Image: ', imageDto.Identifier])
            subplot(2,2,1)
            imshow(imageDto.ImageColor)
            subplot(2,2,2)
            imshow(imageDto.ImageBlackWhite)
            subplot(2,2,3)
            imshow(rgbLabeledData)
            
            figureDetectedAreas = figure('Name', ['Detected areas of interest for: ', imageDto.Identifier]);
            imshow(imageDto.ImageColor)
            hold on
            for index = 1:height(imageDto.CappilaryTable)
                rectangle('Position', imageDto.CappilaryTable.BoundingBox(index, :),...
                    'LineWidth', 1, 'EdgeColor', 'r');
            end
            
            if obj.ExportMode
                warning('off', 'MATLAB:MKDIR:DirectoryExists');
                mkdir(fullfile(obj.ExportDirectory, imageDto.Identifier))
                exportgraphics(figureDetectedAreas, fullfile(obj.ExportDirectory, imageDto.Identifier,...
                    ['Detected_Areas', imageDto.Identifier, '.jpg']), 'Resolution', 300);
            end
        end
    end
end