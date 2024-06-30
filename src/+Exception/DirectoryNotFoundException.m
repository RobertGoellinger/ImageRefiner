classdef DirectoryNotFoundException < MException
    %DIRECTORYNOTFOUNDEXCEPTION The given directory does not exist on your
    %current machine
    
    methods
        function obj = DirectoryNotFoundException(incorrectPath)
            message = 'The provided folder path does not exist on your local machine.';
            if nargin == 1
                message = sprintf('%s\n The supplied path was: "%s" ', message, incorrectPath);
            end
            obj@MException('ImageRefinement:DirectoryNotFoundException', message)
        end
    end
end

