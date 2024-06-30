classdef LogicalErrorException < MException
    %ArgumentException An Exception to be thrown if a function is called
    %with an incorrect type of variable
    
    methods
        function obj = LogicalErrorException(variableName, constraint)
            message = 'The provided arguments are not valid.';
            if nargin == 2
                message = sprintf('%s\n"%s" needs to fullfill the following constraint: "%s"', message, variableName, constraint);
            end
            obj@MException('ImageRefinement:LogicalErrorException', message)
        end
    end
end