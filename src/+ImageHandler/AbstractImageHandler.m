classdef (Abstract) AbstractImageHandler < handle
    %ABSTRACTIMAGEHANDLER Abstract class for handling Image Refinement
    %process
    
    properties (Abstract)
        ImageDtoCollection
    end
    
    methods (Abstract)
        execute(obj);
    end
end

