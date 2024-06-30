classdef VideoDto
    %IMAGE: Data Transfer Object to store meta data for picture
    
    properties (Access = public)
        Identifier
        Name
        RelativePath
    end
    
    methods (Access = public)
        function obj = ImageDto(identifier, name, relativePath)
            if nargin < 1 || ~isa(identifier, 'char')
                throw(Exception.ArgumentException('identifier', 'char'))
            end
            obj.Identifier = identifier;   
            
            if ~isa(name, 'char')
                throw(Exception.ArgumentException('name', 'char'))
            end
            obj.Name = name;
            
            if ~isa(relativePath, 'char')
                throw(Exception.ArgumentException('path', 'char'))
            end
            
            obj.RelativePath = relativePath;
        end
    end
end
