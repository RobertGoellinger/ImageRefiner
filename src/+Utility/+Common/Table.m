classdef Table
    %TABLE Utility functions for table objects
    
    methods (Static)
        function headers = getAllHeaders(tableToCheck)
            if nargin < 1 || ~isa(tableToCheck, 'table')
                throw(Exception.ArgumentException('tableToCheck', 'table'))
            end
            if ~isempty(tableToCheck)
                headers = tableToCheck.Properties.VariableNames;
            else
                headers = {};
            end
        end
    end
    
end
        
        