classdef VideoFrameSplitter < VideoHandler.AbstractVideoHandler
    % VideoFrameSplitter: gather all video files from ImportDirectory, split these videos by frames
    % and save these images to structured subfolders
    
    properties(Access = public)
        ImportDirectory     %@char - Import directory
        VideoDtoCollection  %@cell - Video Data Transfer Object
        VideoExtension      %@char - Image file format
        
    end
    
    methods (Access = public)
        function obj = VideoFrameSplitter(importDirectory, videoExtension)
            %Constructor for a VideoFrameSplitter instance
            if nargin < 1 || ~isa(importDirectory, 'char')
                throw(Exception.ArgumentException('importDirectory', 'char'))
            end
            if nargin < 2 || ~isa(videoExtension, 'char')
                throw(Exception.ArgumentException('videoExtension', 'char'))
            end
            
            obj.ImportDirectory = importDirectory;
            obj.VideoDtoCollection = {};
            obj.VideoExtension = videoExtension;
        end
        
        function execute(obj)
            % Execute the VideoFrameSplitter
            videoFileNamePlaceholder = [filesep, '**', filesep, '*', obj.VideoExtension];
            contentOfDirectory = dir(fullfile(obj.ImportDirectory, videoFileNamePlaceholder));
            isValidFileNameWrapper = @(fileName) Utility.Common.Files.isValidFileName(fileName, '');
            contentOfDirectory = contentOfDirectory(cellfun(isValidFileNameWrapper,...
                {contentOfDirectory.name}));
            logger = Logging.Logger();
            logger.startMessage('VideoFrameSplitter', 'Video Dto Collection')
            logger.info('VideoFrameSplitter', ['A total of ', num2str(length(contentOfDirectory)), ' Videos were detected'])
            
            for indexFile = 1:numel(contentOfDirectory)
                currentEntry = contentOfDirectory(indexFile);
                obj = obj.createVidepDto(currentEntry);
                logger.progressMessage('createVideoDto',indexFile, length(contentOfDirectory))
            end
            logger.finishedMessage('VideoFrameSplitter', 'Video Dto Collection')
        end
    end
    
    methods (Access = private)
        function obj = createVideoDto(obj, currentEntry)
            fileName = currentEntry.name;
            path = currentEntry.folder;
            relativePath = Utility.Common.String.extractRelativePath(path);
            relativePathComponentsList = Utility.Common.String.splitPath(relativePath);
            %type = Enum.TypeEnumeration.classifyType(relativePathComponentsList{end-1});
            identifier = obj.createIdentifier(relativePathComponentsList, fileName);
            
            if Utility.Common.Path.isValidDirectory(relativePathComponentsList, Settings.PATH_PATTERN_TO_CHECK) ...
                    && Utility.Common.Files.isValidFileName(fileName, obj.ColorChannel)
                fullPath = fullfile(path, fileName);
                
                videoDto = DTO.VideoDto(identifier, name, relativePath);
                obj = obj.addVideoDtoToCollection(videoDto);
            end
        end
        
        function identifier = createIdentifier(~, relativePathComponentsList, fileName)
            lastFolder = relativePathComponentsList{end};
            fileNameWithoutExtension = Utility.Common.Files.getName(fileName); 
            identifier = [lastFolder, '_', fileNameWithoutExtension];
        end

        function obj = addVideoDtoToCollection(obj, videoDto)
            % Should probably be an abstract methode in the abstract class
            % AbstractDto or something like that
            videoDtoCollection = obj.VideoDtoCollection;
            videoDtoCollection{end + 1} = videoDto;
            obj.VideoDtoCollection = videoDtoCollection;
        end
    end
end