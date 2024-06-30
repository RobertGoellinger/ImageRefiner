classdef ExcelExporter < Export.AbstractExporter
    %EXCELEXPORTER runs Exports to Excel files
    
    properties (Access = public)
        ExportDirectory
        ImageDtoCollection
        Summary
        Settings
        ColumnsToExport
    end
    
    properties (Constant)
        FILE_EXTENSION = '.xlsx';
    end
    
    methods
        function obj = ExcelExporter(exportDirectory, imageDtoCollection, ...
                summary, columnsToExport, settingsStruct)
            %ExcelExporter: constructs an exporter obj
            logger = Logging.Logger();
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
                logMessage = sprintf('No columns were specified. All columms will be output to excel file\n %s', obj.printAllColumns());
                logger.info('ExcelExporter:printAllColumns', logMessage);
            end
            if isempty(columnsToExport)
                columnsToExport = Utility.Common.Table.getAllHeaders(obj.ImageDtoCollection{1}.CappilaryTable);
                logMessage = sprintf('No columns were specified. All columms will be output to excel file\n %s',...
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
            obj.exportExcelFiles();
            obj.exportSummary();
        end
    end
    
    methods (Access = private)
        function exportExcelFiles(obj)
            warning('OFF','MATLAB:xlswrite:AddSheet');
            logger = Logging.Logger();
            settings = obj.Settings;
            imageDtoCollection = obj.ImageDtoCollection;
            logger.startMessage('ExcelExporter', 'ExcelExporter')
            for indexImageDto = 1:length(imageDtoCollection)
                imageDto = imageDtoCollection{indexImageDto};
                identifier = imageDto.Identifier;
                exportPath = fullfile(obj.ExportDirectory, obj.generateUniqueFileName(identifier));
                exportTable = imageDto.CappilaryTable;
                subtable = obj.selectColumns(exportTable);
                writetable(subtable, exportPath, 'WriteMode', 'append', 'AutoFitWidth', false, 'Sheet', 'Data');
                writecell(settings, exportPath, 'WriteMode', 'append', 'AutoFitWidth', false, 'Sheet', 'Setttings');
                logger.progressMessage('execute',indexImageDto, length(imageDtoCollection));
            end
            logger.finishedMessage('execute', 'Data Export was successful');
        end
        
        function exportSummary(obj)
            warning('OFF','MATLAB:xlswrite:AddSheet');
            logger = Logging.Logger();
            settings = obj.Settings;
            summary = obj.Summary;
            reportPath = fullfile(obj.ExportDirectory, obj.generateUniqueReportName());
            logger.startMessage('execute', 'ExcelExporter')
            writetable(summary, reportPath, 'WriteMode', 'append', 'AutoFitWidth', false, 'Sheet', 1);
            writecell(settings, reportPath , 'WriteMode', 'append', 'Sheet', 2);
            logger.finishedMessage('execute', 'Summary Export was successful');
        end
    end
end

