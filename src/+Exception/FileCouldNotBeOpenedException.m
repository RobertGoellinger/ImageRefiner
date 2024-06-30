classdef FileCouldNotBeOpenedException < MException
    %FILECOULDNOTBEOPENEDEXCEPTION The given file could not be opened on your
    %current machine
    
    methods
        function obj = FileCouldNotBeOpenedException(incorrectPath)
            %FILECOULDNOTBEOPENEDEXCEPTION Construct an instance of this class
            message = 'The provided file could not be opened on your local machine.';
            if nargin == 1
                message = sprintf('%s\n The supplied path was: "%s" ', message, incorrectPath);
            end
            obj@MException('ImageRefinement:FileCouldNotBeOpenedException', message)
        end
    end
end