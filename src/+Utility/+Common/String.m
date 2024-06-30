classdef String
    %STRING Contains common utility functions for dealing with strings
    
    methods (Access = public, Static)
        
        function pathList = splitPath(path)
            if nargin < 1 || ~isa(path, 'char')
                throw(Exception.ArgumentException('path', 'char'))
            end
            pathList = regexp(path, filesep, 'split');
        end
        
        function pathList = splitString(string, stringSeparator)
            if nargin < 1 || ~isa(string, 'char')
                throw(Exception.ArgumentException('string', 'char'))
            end
            pathList = regexp(string, stringSeparator, 'split');
        end
        
        function relativePathList = splitRelativePath(path)
            if nargin < 1 || ~isa(path, 'char')
                throw(Exception.ArgumentException('path', 'char'))
            end
            relativePath = Utility.Common.String.extractRelativePath(path);
            relativePathList = Utility.Common.String.splitPath(relativePath);
        end
        
        function relativePath = extractRelativePath(path)
            if nargin < 1 || ~isa(path, 'char')
                throw(Exception.ArgumentException('path', 'char'))
            end
            relativePath = erase(path, Settings.IMPORT_PATH);
        end
        
        function newStr = removeWhiteSpaces(str)
            if nargin < 1 || ~isa(path, 'char')
                throw(Exception.ArgumentException('path', 'char'))
            end
            newStr = strtrim(str);
        end
        
        function status = endsWith(string, pattern)
            if nargin < 1 || ~isa(string, 'char')
                throw(Exception.ArgumentException('string', 'char'))
            end
            if ~isa(pattern, 'char')
                throw(Exception.ArgumentException('pattern', 'char'))
            end
            
            patternToCheck = [pattern, '$'];
            if any(regexp(string, patternToCheck))
                status = 1;
            else
                status = 0;
            end
        end
        
        function status = startsWith(string, pattern)
            if nargin < 1 || ~isa(string, 'char')
                throw(Exception.ArgumentException('string', 'char'))
            end
            if ~isa(pattern, 'char')
                throw(Exception.ArgumentException('pattern', 'char'))
            end
            
            patternToCheck = ['^', pattern];
            if any(regexp(string, patternToCheck))
                status = 1;
            else
                status = 0;
            end
        end
        
        function string = cutOffSubstring(stringToCut, pattern)
            if nargin < 1 || ~isa(stringToCut, 'char')
                throw(Exception.ArgumentException('stringToCut', 'char'))
            end
            if ~isa(pattern, 'char')
                throw(Exception.ArgumentException('pattern', 'char'))
            end
            
            indexToCut = regexp(stringToCut, pattern, 'once');
            if isempty(indexToCut)
                throw(Exception.LogicalErrorException('stringToCut', 'stringToCut does not contain the pattern'))
            end
            
            string = stringToCut(1:indexToCut-1);
        end
    end
end

