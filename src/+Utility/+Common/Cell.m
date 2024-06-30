classdef Cell
    %CELLS Utility functions for cell objects
    
    methods (Static)
        function status = contains(cellToCheck, str)
            if nargin < 1 || ~isa(cellToCheck, 'cell')
                throw(Exception.ArgumentException('cellToCheck', 'cell'))
            end
            if nargin < 2 || ~isa(str, 'char')
                throw(Exception.ArgumentException('str', 'char'))
            end
            
            status = false;
            for index = 1:numel(cellToCheck)
                if strcmp(cellToCheck{index}, str)
                    status = true;
                    break;
                end
            end
        end
        
        function output = printAllEntriesOfCell(cellToExport)
            if nargin < 1 || ~isa(cellToExport, 'cell')
                throw(Exception.ArgumentException('cellToExport', 'cell'))
            end
            
            output = '';
            for index = 1:length(cellToExport)
                if index == 1
                    OUTPUT_TEMPLATE = '%s%s';
                else
                    OUTPUT_TEMPLATE = '%s , %s';
                end
                output = sprintf(OUTPUT_TEMPLATE, output, cellToExport{index});
            end
        end
    end
end

