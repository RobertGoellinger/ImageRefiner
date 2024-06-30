classdef ImageDto
    %IMAGE: Data Transfer Object to store meta data for picture
    
    properties (Access = public)
        Identifier
        Name
        Type
        ColorChannel
        RelativePath
        ImageColor
        ImageBlackWhite
        CappilaryTable
        SummaryDto
        ConnectedComponents
        ImageInformation
    end
    
    methods (Access = public)
        function obj = ImageDto(identifier, name, type, colorChannel, relativePath, imageColor,...
                imageBlackWhite, imageInformation)
            if nargin < 1 || ~isa(identifier, 'char')
                throw(Exception.ArgumentException('identifier', 'char'))
            end
            obj.Identifier = identifier;   
            
            if ~isa(name, 'char')
                throw(Exception.ArgumentException('name', 'char'))
            end
            obj.Name = name;
            
            if ~isa(type, 'Enum.TypeEnumeration')
                throw(Exception.ArgumentException('type', 'Enum.TypeEnumeration'))
            end
            obj.Type = type;
            
            if ~isa(colorChannel, 'Enum.ColorChannelEnum')
                throw(Exception.ArgumentException('colorChannel', 'Enum.ColorChannelEnum'))
            end
            obj.ColorChannel = colorChannel.toString();
            
            if ~isa(relativePath, 'char')
                throw(Exception.ArgumentException('path', 'char'))
            end
            
            if ~isa(imageInformation, 'struct')
                throw(Exception.ArgumentException('imageInformation', struct))
            end
            
            obj.RelativePath = relativePath;
            obj.ImageColor = imageColor;
            obj.ImageBlackWhite = imageBlackWhite;
            obj.ImageInformation = imageInformation;
        end
        
        function obj = addCappilaryTable(obj, cappilaryTable)
            if nargin < 2 || ~isa(cappilaryTable, 'table')
                throw(Exception.ArgumentException('cappilaryTable', 'table'))
            end
            obj.CappilaryTable = cappilaryTable;
        end
    end
end
