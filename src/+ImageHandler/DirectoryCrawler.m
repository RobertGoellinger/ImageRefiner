classdef DirectoryCrawler < ImageHandler.AbstractImageHandler
    %DirectoryCrawler: gather all Images from ImportDirectory and save them
    %to the ImageDtoCollection
    
    properties(Access = public)
        ImportDirectory     %@char - Import directory
        ImageDtoCollection  %@cell - Image Data Transfer Object
        ColorChannel        %@Enum.ColorChannelEnum
        ImageExtension      %@char - Image file format
        PixelSizeOfArtifacts %@double - parameter for image analysis
        ThresholdBlackWhiteImage %@double - parameter for image analysis
    end
    
    methods (Access = public)
        function obj = DirectoryCrawler(importDirectory, colorChannel, imageExtension, pixelSizeOfArtifacts, thresholdBlackWhiteImage)
            %Constructor for a DirectoryCrawler instance
            if nargin < 1 || ~isa(importDirectory, 'char')
                throw(Exception.ArgumentException('importDirectory', 'char'))
            end
            if nargin < 2 || ~isa(colorChannel, 'Enum.ColorChannelEnum')
                throw(Exception.ArgumentException('colorChannel', 'Enum.ColorChannelEnum'))
            end
            if nargin < 3 || ~isa(imageExtension, 'char')
                throw(Exception.ArgumentException('imageExtension', 'char'))
            end
            if nargin < 4 || ~isa(pixelSizeOfArtifacts, 'double')
                throw(Exception.ArgumentException('pixelSizeOfArtifacts', 'double'))
            end
            if nargin < 5 || ~isa(thresholdBlackWhiteImage, 'double')
                throw(Exception.ArgumentException('thresholdBlackWhiteImage', 'double'))
            end
            
            obj.ImportDirectory = importDirectory;
            obj.ImageDtoCollection = {};
            obj.ColorChannel = colorChannel;
            obj.ImageExtension = imageExtension;
            obj.PixelSizeOfArtifacts = pixelSizeOfArtifacts;
            obj.ThresholdBlackWhiteImage = thresholdBlackWhiteImage;
        end
        
        function execute(obj)
            % Execute the DirectoryCrawler
            imageNamePlaceholder = [filesep, '**', filesep, '*', obj.ImageExtension];
            contentOfDirectory = dir(fullfile(obj.ImportDirectory, imageNamePlaceholder));
            isValidFileNameWrapper = @(fileName) Utility.Common.Files.isValidFileName(fileName, obj.ColorChannel);
            contentOfDirectory = contentOfDirectory(cellfun(isValidFileNameWrapper,...
                {contentOfDirectory.name}));
            logger = Logging.Logger();
            logger.startMessage('DirectoryCrawler', 'Image Dto Collection')
            logger.info('DirectoryCrawler', ['A total of ', num2str(length(contentOfDirectory)), ' Images were detected'])
            
            for indexFile = 1:numel(contentOfDirectory)
                currentEntry = contentOfDirectory(indexFile);
                obj = obj.createImageDto(currentEntry);
                logger.progressMessage('createImageDto',indexFile, length(contentOfDirectory))
            end
            logger.finishedMessage('DirectoryCrawler', 'Image Dto Collection')
        end
    end
    
    methods (Access = private)
        function obj = createImageDto(obj, currentEntry)
            fileName = currentEntry.name;
            path = currentEntry.folder;
            relativePath = Utility.Common.String.extractRelativePath(path);
            relativePathComponentsList = Utility.Common.String.splitPath(relativePath);
            type = Enum.TypeEnumeration.classifyType(relativePathComponentsList{end-1});
            identifier = obj.createIdentifier(relativePathComponentsList, fileName);
            
            if Utility.Common.Path.isValidDirectory(relativePathComponentsList, Settings.PATH_PATTERN_TO_CHECK) ...
                    && Utility.Common.Files.isValidFileName(fileName, obj.ColorChannel)
                fullPath = fullfile(path, fileName);
                imageColor = imread(fullPath);
                imageInformation = imfinfo(fullPath);
                imageBlackWhite = obj.createBlackWhiteImage(imageColor);
                name = Utility.Common.String.cutOffSubstring(fileName, ...
                    obj.ColorChannel.toString());
                
                imageDto = DTO.ImageDto(identifier, name, type, obj.ColorChannel,...
                    relativePath, imageColor, imageBlackWhite, imageInformation);
                obj = obj.addImageDtoToCollection(imageDto);
            end
        end
        
        function identifier = createIdentifier(~, relativePathComponentsList, fileName)
            lastFolder = relativePathComponentsList{end};
            fileNameWithoutExtension = Utility.Common.Files.getName(fileName); 
            identifier = [lastFolder, '_', fileNameWithoutExtension];
        end
        
        function imageBlackWhite = createBlackWhiteImage(obj, imageColor)
            imageBlackWhiteWithArtifacts = rgb2gray(imageColor);
            morphologicalObj = strel('disk', obj.PixelSizeOfArtifacts);
            background = imopen(imageBlackWhiteWithArtifacts, morphologicalObj);
            filteredImage = imageBlackWhiteWithArtifacts - background;
            grayThreshold = graythresh(filteredImage);
            imageBlackWhiteBinary = imbinarize(filteredImage, grayThreshold);
            imageBlackWhite = bwareaopen(imageBlackWhiteBinary, obj.ThresholdBlackWhiteImage);
        end
        
        function obj = addImageDtoToCollection(obj, imageDto)
            imageDtoCollection = obj.ImageDtoCollection;
            imageDtoCollection{end + 1} = imageDto;
            obj.ImageDtoCollection = imageDtoCollection;
        end
    end
end