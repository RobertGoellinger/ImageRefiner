classdef JsonExporter < Export.AbstractExporter
    %JSONEXPORTER: Exports generated reports to a specified file type
    
    properties
        ExportDirectory
        ImageDtoCollection
        Summary
        Settings
        ColumnsToExport
    end
        
    properties (Constant)
        FILE_EXTENSION = '.json';
    end
    
    methods
        function obj = JsonExporter(exportDirectory, imageDtoCollection, summary,...
                columnsToExport, settingsStruct)
            %Exporter: constructs an exporter obj
            if nargin < 1 || ~isa(exportDirectory, 'char')
                throw(Exception.ArgumentException('exportDirectory', 'char'))
            end
            
            if ~isfolder(exportDirectory)
                throw(Exception.DirectoryNotFoundException(exportDirectory))
            end
            
            if nargin < 2 || ~isa(imageDtoCollection, 'cell')
                throw(Exception.ArgumentException('imageDtoCollection', 'cell'))
            end
            
            if nargin < 3 || ~isa(summary, 'table')
                throw(Exception.ArgumentException('exportDirectory', 'table'))
            end
            
            obj.ExportDirectory = exportDirectory;
            obj.ImageDtoCollection = imageDtoCollection;
            obj.Summary = summary;
                      
            if nargin < 4
                columnsToExport = Utility.Common.Table.getAllHeaders(obj.ImageDtoCollection{1}.CappilaryTable);
                logMessage = sprintf('No columns were specified. All columms will be output to json file\n %s',...
                Utility.Common.Cell.printAllEntriesOfCell(columnsToExport));
                logger.info('ExcelExporter:printAllColumns', logMessage);
            end
            if isempty(columnsToExport)
                columnsToExport = Utility.Common.Table.getAllHeaders(obj.ImageDtoCollection{1}.CappilaryTable);
                logMessage = sprintf('No columns were specified. All columms will be output to json file\n %s',...
                    Utility.Common.Cell.printAllEntriesOfCell(columnsToExport));
                logger.info('ExcelExporter:printAllColumns', logMessage);
            end
            
            if ~isa(columnsToExport, 'cell')
                throw(Exception.ArgumentException('selectionRows', 'cell'))
            end
            if ~obj.checkColumnNames(columnsToExport)
                throw(Exception.LogicalErrorException('columnsToExport', 'use the correct column names'))
            end
            
            if nargin < 5 || ~isa(settingsStruct, 'struct')
                throw(Exception.ArgumentException('settingsStruct', 'struct'))
            end
            
            obj.ColumnsToExport = columnsToExport;
            obj.Settings = Settings.gatherSettings(settingsStruct);
        end
        
        function execute(obj)
            try
                obj.exportJson()
            catch err
                logger = Logging.Logger();
                logger.warn('JsonExporter', err.getReport());
            end
        end
    end
    
    methods (Access = private)
        function exportJson(obj)
            for index = 1:length(obj.ImageDtoCollection)
                imageDto = obj.ImageDtoCollection{index};
                exportTable = imageDto.CappilaryTable;
                subTable = obj.selectColumns(exportTable);
                fileName = obj.generateUniqueFileName(imageDto.Identifier);
                exportFilePath = fullfile(obj.ExportDirectory, fileName);
                Utility.Common.Json.writeJson(exportFilePath, table2struct(subTable));
            end
        end
    end
end


