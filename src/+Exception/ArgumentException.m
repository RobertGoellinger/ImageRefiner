classdef ArgumentException < MException
    %ArgumentException An Exception to be thrown if a function is called
    %with an incorrect type of variable
    
    methods
        function obj = ArgumentException(varName, varType)
            message = 'The provided arguments are not valid.';
            if nargin == 2
                message = sprintf('%s\n"%s" must be of type "%s"', message, varName, varType);
            end
            obj@MException('ImageRefinement:ArgumentException', message)
        end
    end
end

