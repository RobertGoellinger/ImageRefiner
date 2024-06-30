classdef NoSuchFlowException < MException
    %NoSuchFlowException An Exception to be thrown if an unimplemented flow is being executed
        
    methods
        function obj = NoSuchFlowException()
            message = 'This function has not yet been implemented.';
            obj@MException('ImageRefinement:NoSuchFlowException', message)
        end
    end
end