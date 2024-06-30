classdef Json < handle
    % JSON Utility functions for writing Json files
    
    methods (Access = public, Static)
        function jsonStruct = readJson(filePath)
            if nargin < 1 || ~isa(filePath, 'char')
                throw(Exception.ArgumentException('filePath', 'char'))
            end
            if ~Utility.Common.Files.exists(filePath)
                throw(Exception.LogicalErrorException(filePath, 'does not exist!'))
            end
            jsonString = Utility.Common.Files.read(filePath);
            jsonStruct = matlab.internal.webservices.fromJSON(jsonString);
        end
        
        function writeJson(filePath, structToWrite)
            if nargin < 1 || ~isa(filePath, 'char')
                throw(Exception.ArgumentException('filePath', 'char'))
            end
            if nargin < 2 || ~isa(structToWrite, 'struct')
                throw(Exception.ArgumentException('structToWrite', 'struct'))
            end
            jsonString = matlab.internal.webservices.toJSON(structToWrite);
            Utility.Common.Files.write(filePath, jsonString);
        end
    end
end