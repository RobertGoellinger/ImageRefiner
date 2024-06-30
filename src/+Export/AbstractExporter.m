classdef (Abstract) AbstractExporter
    %ABSTRACTEXPORTER Prototype for all exporter classes
    
    properties (Abstract)
        ExportDirectory
        ImageDtoCollection
        Summary
        Settings
    end
    
    properties (Constant, Access = protected)
        FILE_NAME_TO_EXPORT = 'ImageRefiner_Report_IDENTIFIER_UUID';
        REPORT_NAME_TO_EXPORT = 'ImageRefiner_Summary_UUID';
        TEMPLATE = {'BiopsieNumber', 'CortexMedulla', 'PictureIdentifier', 'NumberOfCappilaries',...
            'AreaMean','AreaMedian', 'PerimeterMean', 'PerimeterMedian',...
            'MinFeretDiameterMean', 'MinFeretDiameterMedian', 'MaxFeretDiameterMean', 'MaxFeretDiameterMedian'};
    end
    
    properties (Abstract, Constant)
        FILE_EXTENSION;
    end
    
    methods (Abstract)
        execute(obj);
    end
    
    methods
        function template = getTemplate(obj)
            template = obj.TEMPLATE;
        end
        
        function fileName = generateUniqueFileName(obj, identifier)
            uuid = Utility.Common.Java.generateUUID();
            fileName = strrep(obj.FILE_NAME_TO_EXPORT, 'UUID', uuid);
            fileName = strrep(fileName, 'IDENTIFIER', identifier);
            fileName = [fileName, obj.FILE_EXTENSION];
        end
        
        function reportName = generateUniqueReportName(obj)
            uuid = Utility.Common.Java.generateUUID;
            reportName = strrep(obj.REPORT_NAME_TO_EXPORT, 'UUID', uuid);
            reportName = [reportName, obj.FILE_EXTENSION];
        end
        
        function status = checkColumnNames(obj, columnsToExport)
            columnNames = Utility.Common.Table.getAllHeaders(obj.ImageDtoCollection{1}.CappilaryTable);
            status = true;
            for indexColumnNames = 1:length(columnsToExport)
                if ~Utility.Common.Cell.contains(columnNames, columnsToExport{indexColumnNames})
                    status = false;
                    break;
                end
            end
        end
        
        function subTable = selectColumns(obj, exportTable)
            columns = obj.ColumnsToExport;
            subTable = table();
            for index = 1:length(columns)
                columnName = columns{index};
                subTable.(columnName) = exportTable.(columnName);
            end
        end
    end
end

