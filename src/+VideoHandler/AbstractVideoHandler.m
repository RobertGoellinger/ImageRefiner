classdef (Abstract) AbstractVideoHandler < handle
    % AbstractVideoHandler: Abstract class for handling Video Preprocessing
    
    properties (Abstract)
        VideoDtoCollection
    end
    
    methods (Abstract)
        execute(obj);
    end
end

