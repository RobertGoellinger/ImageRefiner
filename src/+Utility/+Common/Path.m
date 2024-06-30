classdef Path
    %PATH Contains common utility functions for dealing with Paths
    
    methods (Access = public, Static)
        function state = isValidDirectory(pathComponentList, patternToCheck)
            if nargin < 1 || ~isa(pathComponentList, 'cell')
                throw(Exception.ArgumentException('pathComponentList', 'cell'))
            end
            
            if nargin < 2 || ~isa(patternToCheck, 'char')
                throw(Exception.ArgumentException('patternToCheck', 'char'))
            end
            
            state = 0;
            for indexPath = length(pathComponentList):-1:1
                if regexp(pathComponentList{indexPath}, patternToCheck)
                    state = 1;
                    break;
                end
            end
        end
        
        function normPath = normalizePath(physicalPath)
            if nargin < 1 || ~isa(physicalPath, 'char')
                throw(Exception.ArgumentException('physicalPath', 'char'))
            end
            normPath = strrep(physicalPath, filesep, [filesep, filesep]);
        end      

    end
end
