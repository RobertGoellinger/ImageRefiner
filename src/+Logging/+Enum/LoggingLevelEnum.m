classdef LoggingLevelEnum < uint8
    %LOGGINGLEVELENUM Enumerations for Logging
    
    enumeration
        ALL     (0)
        TRACE   (1)
        DEBUG   (2)
        INFO    (3)
        WARN    (4)
        ERROR   (5)
        FATAL   (6)
        OFF     (7)
        UNKNOWN (8)
    end
    
    methods (Access = public)
        function levelStr = toString(obj)
            switch obj
                case Logging.Enum.LoggingLevelEnum.TRACE
                    levelStr = 'TRACE';
                case Logging.Enum.LoggingLevelEnum.DEBUG
                    levelStr = 'DEBUG';
                case Logging.Enum.LoggingLevelEnum.INFO
                    levelStr = 'INFO';
                case Logging.Enum.LoggingLevelEnum.WARN
                    levelStr = 'WARN';
                case Logging.Enum.LoggingLevelEnum.ERROR
                    levelStr = 'ERROR';
                case Logging.Enum.LoggingLevelEnum.FATAL
                    levelStr = 'FATAL';
                case Logging.Enum.LoggingLevelEnum.OFF
                    levelStr = '';
                otherwise
                    levelStr = 'UNKNOWN';
            end
        end
    end
end

