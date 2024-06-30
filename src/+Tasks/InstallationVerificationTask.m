classdef InstallationVerificationTask < Tasks.AbstractTask
    % INSTALLATIONVERIFICATIONTASK A class to be called to check if the
    % installation of the ImageRefiner was successfull
    
    properties
        PathToBaseDirectory
    end
    
    methods 
        function obj = InstallationVerificationTask(pathToBaseDirectory)
            if nargin < 1 || ~isa(pathToBaseDirectory, 'char')
                throw(Exception.ArgumentException('pathToBaseDirectory', 'char'))
            end
            obj.PathToBaseDirectory = pathToBaseDirectory;
        end
            
        function status = verifyInstallation(obj)
            
        end
    end
    
    methods (Static)
        function status = verifyData(pathToData)
            relativePath = Utility.Common.Path.normalizePath(pathToData);
        end 
    end
end
        