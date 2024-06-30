classdef FileNotFoundException < MException
    %FILENOTFOUNDEXCEPTION The given file does not exist on your
    %current machine
    
    methods
        function obj = FileNotFoundException(incorrectPath)
            %FILENOTFOUNDEXCEPTION Construct an instance of this class
            message = 'The provided file name does not exist on your local machine.';
            if nargin == 1
                message = sprintf('%s\n The supplied path was: "%s" ', message, incorrectPath);
            end
            obj@MException('ImageRefinement:FileNotFoundException', message)
        end
    end
end

