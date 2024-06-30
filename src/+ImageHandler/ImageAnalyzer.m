classdef ImageAnalyzer < ImageHandler.AbstractImageHandler
    %ImageAnalyzer: Analyze all images from the ImageDtoCollection and
    %construct the data export
    
    properties(Access = public)
        ImageDtoCollection;         %@cell of DTO.ImageDto
        SummaryCollection;          %@structure
        Connectivity;               %@double - Connectivity parameter for determining connected components
        AreaBounds;                 %@double [1x2] - Upper and lower bound for areas of interest
        ScalePixelToMicrometer;     %@double - Conversion factor
    end
    
    methods (Access = public)
        function obj = ImageAnalyzer(imageDtoCollection, connectivity, areaBounds, scalePixelToMicrometer)
            %Constructor for an ImageAnalyzer instance
            if nargin < 1 || ~isa(imageDtoCollection, 'cell')
                throw(Exception.ArgumentException('imageDtoCollection', 'cell'))
            end
            
            if nargin < 2 || ~isa(connectivity, 'double')
                throw(Exception.ArgumentException('connectivity', 'double'))
            end
            
            if nargin < 3 || ~isa(areaBounds, 'double')
                throw(Exception.ArgumentException('areaBounds', 'double'))
            end
            
            if nargin < 4 || ~isa(scalePixelToMicrometer, 'double')
                throw(Exception.ArgumentException('scalePixelToMikrometer', 'double'))
            end
            
            obj.ImageDtoCollection = imageDtoCollection;
            obj.SummaryCollection = table();
            obj.Connectivity = connectivity;
            obj.AreaBounds = areaBounds;
            obj.ScalePixelToMicrometer = scalePixelToMicrometer;
        end
        
        function execute(obj)
            imageDtoCollection = obj.ImageDtoCollection;
            if isempty(imageDtoCollection)
                throw(Exception.LogicalErrorException('imageDtoCollection', 'should not be empty. Possibly image names are not correct!'))
            end
            
            logger = Logging.Logger();
            logger.startMessage('ImageAnalyzer','Image Analysis')
            
            for indexDto = 1:length(imageDtoCollection)
                imageDto = imageDtoCollection{indexDto};
                imageDtoAnalyzed = obj.analyseImageDto(imageDto);
                summary(indexDto) = obj.createSummaryStructure(imageDtoAnalyzed);
                obj.ImageDtoCollection{indexDto} = imageDtoAnalyzed;
                logger.progressMessage('ImageAnalyzer', indexDto, length(imageDtoCollection))
            end
            
            obj.SummaryCollection = struct2table(summary);
            obj.SummaryCollection.Properties.Description = 'Evaluation of nephrological images';
            
            logger.finishedMessage('ImageAnalyzer','Image Analysis')
        end
    end
    
    methods (Access = private)
        function imageDto = analyseImageDto(obj, imageDto)
            [cappilaryData, imageDto.ConnectedComponents] = obj.generateCappilaryData(imageDto);
            cappilaryTable = obj.createCappilaryTable(cappilaryData);
            imageDto = imageDto.addCappilaryTable(cappilaryTable);
        end
        
        function [scaledCappilaryData, connectedComponents] = generateCappilaryData(obj, imageDto)
            imageBlackWhite = imageDto.ImageBlackWhite;
            imageColor = imageDto.ImageColor;
            connectedComponents = bwconncomp(imageBlackWhite, obj.Connectivity);
            cappilaryData = regionprops(connectedComponents, 'all');
            scaledCappilaryData = obj.scaleCappilaryData(cappilaryData);
        end
        
        function scaledCappilaryData = scaleCappilaryData(obj, cappilaryData)
            scale = obj.ScalePixelToMicrometer;
            area = [cappilaryData.Area];
            perimeter = [cappilaryData.Perimeter];
            minFeretDiameter = [cappilaryData.MinFeretDiameter];
            maxFeretDiameter = [cappilaryData.MaxFeretDiameter];
            scaledCappilaryData = cappilaryData;
            for index = 1:length(cappilaryData)
                scaledCappilaryData(index).Area = area(index).*(scale^2);
                scaledCappilaryData(index).Perimeter = perimeter(index).*scale;
                scaledCappilaryData(index).MinFeretDiameter = minFeretDiameter(index).*scale;
                scaledCappilaryData(index).MaxFeretDiameter = maxFeretDiameter(index).*scale;
            end
        end
        
        function cappilaryTable = createCappilaryTable(obj, cappilaryData)
            cappilaryTable = struct2table(cappilaryData);
            cappilaryTable = obj.filterCappilaryTable(cappilaryTable);
        end
        
        function filteredCappilaryTable = filterCappilaryTable(obj, cappilaryTable)
            indexCondition1 = cappilaryTable.Area(:) > obj.AreaBounds(1);
            indexCondition2 = cappilaryTable.Area(:) < obj.AreaBounds(2);
            indexConditionFullfilled = and(indexCondition1, indexCondition2);
            filteredCappilaryTable = cappilaryTable(indexConditionFullfilled, :);
        end
        
        function summary = createSummaryStructure(obj, imageDto)
            cappilaryTable = imageDto.CappilaryTable;
            summary.BiopsieIdentifier = obj.findValidIdentifier(imageDto.Identifier);
            type = imageDto.Type;
            summary.Classification = type.toString();
            summary.NumberOfCappilaries = height(cappilaryTable);
            summary.AreaMean = mean(cappilaryTable{:,1});
            summary.AreaMedian = median(cappilaryTable{:,1});
            summary.PerimeterMean = mean(cappilaryTable{:,23});
            summary.PerimeterMedian = median(cappilaryTable{:,23});
            summary.MinFeretDiameterMean = mean(cappilaryTable{:,28});
            summary.MinFeretDiameterMedian = median(cappilaryTable{:,28});
            summary.MaxFeretDiameterMean = mean(cappilaryTable{:,25});
            summary.MaxFeretDiameterMedian = median(cappilaryTable{:,25});
        end
        
        function stringMatch = findValidIdentifier(~, identifier)
            stringMatch = regexp(identifier, ['^', Settings.IDENTIFIER_PATTERN_TO_CHECK], 'match');
            if isempty(stringMatch)
                stringMatch = 'INVALID_IDENTIFIER';
                logger = Logging.Logger();
                logger.warn('ImageAnalyzer:findValidIdentifier', ['Invalid identifier used as a picture name: ', identifier, ' '...
                    ' Please make sure to adhere to the regexp pattern specified in Settings.PATH_PATTERN_TO_CHECK']);
            end
        end
    end
end
