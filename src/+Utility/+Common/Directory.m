classdef Directory < handle
    % DIRECTORY Utility functions used for manipulating directories
    methods (Access = public, Static)
        
        function directoryExists = exists(physicalPath)
            if nargin < 1 || ~isa(physicalPath, 'char')
                throw(Exception.ArgumentException('physicalPath', 'char'))
            end
            
            if isequal(exist(physicalPath, 'dir'), 7)
                directoryExists = true;
                message = 'exists';
            else
                directoryExists = false;
                message = 'does not exist';
            end
            logger = Logging.Logger();
            logger.debug(sprintf('File: %s %s.', physicalPath, message));
        end
        
        function isDir = isDirectory(physicalPath)
            if nargin < 1 || ~isa(physicalPath, 'char')
                throw(Exception.ArgumentException('physicalPath', 'char'))
            end
            isDir = isequal(exist(physicalPath, 'dir'), 7);
        end
        
        function status = createIfNotExists(physicalPath)
            if nargin < 1 || ~isa(physicalPath, 'char')
                throw(Exception.ArgumentException('physicalPath', 'char'))
            end
            physicalPath = Utility.Common.Path.normalizePath(physicalPath);
            % Not completed
        end
        
        function commonPath = getCommonPath(firstPath, secondPath)
            if nargin < 1 || ~isa(firstPath, 'char')
                throw(Exception.ArgumentException('firstPath', 'char'))
            end
            if nargin < 1 || ~isa(secondPath, 'char')
                throw(Exception.ArgumentException('secondPath', 'char'))
            end
            % Not Completed
        end
        
    end