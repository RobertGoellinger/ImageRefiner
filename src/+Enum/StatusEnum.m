classdef StatusEnum < uint8
    %TASKSTATUSENUM class for running the GUI
    
    enumeration
        Startup             (0)
        DirectoryCrawler    (1)
        ImageAnalyzer       (2)
        Exporter            (3)
    end
    
    methods (Access = public)
        function
            
        end
    end
    
end