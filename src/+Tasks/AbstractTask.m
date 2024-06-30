classdef (Abstract) AbstractTask
    %AbstractTask: An abstract class from which all Tasks classes derive
    %their behaviours
    
    methods (Abstract)
        status = execute(obj)
    end
end

