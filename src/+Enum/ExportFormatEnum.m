classdef ExportFormatEnum
    %ExportFormatEnum Enumeration class for desired export format
    
    enumeration
        EXCEL;
        JSON;
        ALL;
        NOT_CLASSIFIED;
    end
    
    methods (Static)
        function obj = classify(exportFormat)
            if strcmpi(exportFormat, 'EXCEL')
                obj = Enum.ExportFormatEnum.EXCEL;
            elseif strcmpi(exportFormat, 'JSON')
                obj = Enum.ExportFormatEnum.JSON;
            elseif strcmpi(exportFormat, 'ALL')
                obj = Enum.ExportFormatEnum.ALL;
            else
                obj = Enum.ExportFormatEnum.NOT_CLASSIFIED;
            end
        end
    end
end