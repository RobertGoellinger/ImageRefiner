classdef Files
    %Files Contains common utility functions for dealing with Files
    
    methods (Access = public, Static)
        function state = isValidFileName(fileName, colorChannel)
            if nargin < 1 || ~isa(fileName, 'char')
                throw(Exception.ArgumentException('fileName', 'char'))
            end
            if nargin < 2 || ~isa(colorChannel, 'Enum.ColorChannelEnum')
                throw(Exception.ArgumentException('colorChannel', 'Enum.ColorChannelEnum'))
            end
            if any(regexp(fileName, colorChannel.toString()))...
                    && ~any(regexp(fileName, '^._'))
                state = true;
            else
                state = false;
            end
        end
        
        function fileExists = exists(physicalPath)
            if nargin < 1 || ~isa(physicalPath, 'char')
                throw(Exception.ArgumentException('physicalPath', 'char'))
            end
            
            if isequal(exist(physicalPath, 'file'), 2) || isequal(exist(physicalPath, 'file'), 4)
                fileExists = true;
                message = 'exists';
            else
                fileExists = false;
                message = 'does not exist';
            end
            logger = Logging.Logger();
            logger.debug(sprintf('File: %s %s.', physicalPath, message));
        end
        
        function existingFilesIndices = existFiles(physicalPaths)
            if nargin < 1 || ~isa(physicalPaths, 'cell')
                throw(Exception.ArgumentException('physicalPath', 'cell'))
            end
            existingFilesIndices = zeros(length(physicalPaths), 1);
            for index = 1:length(physicalPaths)
                existingFilesIndices(index, 1) = Utility.Common.Files.exists(physicalPaths{index});
            end
        end
        
        function createEmptyFile(directory, name)
            if nargin < 1 || ~isa(directory, 'char')
                throw(Exception.ArgumentException('directory', 'char'))
            end
            if nargin < 2 || ~isa(name, 'char')
                throw(Exception.ArgumentException('directory', 'char'))
            end
            Utility.Common.Directory.createIfNotExists(directory)
            % Not done yet
        end
        
        function name = getName(fileName)
            if nargin < 1 || ~isa(fileName, 'char')
                throw(Exception.ArgumentException('fileName', 'char'))
            end
            [~, name, ~] = fileparts(fileName);
        end
        
        function extension = getExtension(fileName)
            if nargin < 1 || ~isa(fileName, 'char')
                throw(Exception.ArgumentException('fileName', 'char'))
            end
            [~, ~, extension] = fileparts(fileName);
        end
        
        function directory = getDirectory(fileName)
            if nargin < 1 || ~isa(fileName, 'char')
                throw(Exception.ArgumentException('fileName', 'char'))
            end
            [directory, ~, ~] = fileparts(fileName);
        end
        
        function fileContent = read(filePath, seekBOM)
            if nargin < 1 || ~isa(filePath, 'char')
                throw(Exception.ArgumentException('filePath', 'char'))
            end
            if nargin < 2 
                seekBOM = false;
            end
            if ~isa(seekBOM, 'logical')
                throw(Exception.ArgumentException('seekBOM', 'logical'))
            end
            
            if Utility.Common.Files.exists(filePath)
                logger = Logging.Logger();
                fid = fopen(filePath, 'r', 'n', 'UTF-8');
                if fid == -1 
                    throw(Exception.FileCouldNotBeOpenedException(filePath))
                end
                if seekBOM
                    fseek(fid, 3, 'bof');
                end
                fileContent = fread(fid, '*char')';
                fclose(fid);
                logger.debug(sprintf('File read "%s"', filePath));
            else
                throw(Exception.FileNotFoundException(filePath))
            end
        end
        
        function write(filePath, content, permission)
            if nargin < 1 || ~isa(filePath, 'char')
                throw(Exception.ArgumentException('filePath', 'char'))
            end
            if nargin < 2 || ~isa(content, 'char') 
                throw(Exception.ArgumentException('content', 'char'))
            end
            if nargin < 3
                permission = 'w';
            end
            if ~isa(permission, 'char')
                throw(Exception.ArgumentException('permission', 'char'))
            end
            fid = fopen(filePath, permission, 'n', 'UTF-8');
            
            if fid == -1 
                 throw(Exception.FileCouldNotBeOpenedException(filePath))
            end
            fwrite(fid, content);
            fclose(fid);
        end
            
    end
end