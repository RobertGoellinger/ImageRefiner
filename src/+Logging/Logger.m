classdef Logger < handle
    % Based upon the logger log4m by Luke Winslow
    % Luke Winslow (2021). log4m - A powerful and simple logger for matlab
    % (https://www.mathworks.com/matlabcentral/fileexchange/37701-log4m-a-powerful-and-simple-logger-for-matlab)
    % MATLAB Central File Exchange. Retrieved January 7, 2021.
    
    properties(Access = protected)
        logger;
        LogFile;
    end
    
    properties(SetAccess = protected)
        FullPath = fullfile(Settings.DEFAULT_LOGGING_PATH, Settings.LOG_FILE_NAME);
        CommandWindowLevel = Logging.Enum.LoggingLevelEnum.ALL;
        LogLevel = Logging.Enum.LoggingLevelEnum.INFO;
    end
    
    methods (Static)
        function obj = getLogger(pathToLogFile)
            if nargin < 1 || ~isa(pathToLogFile, 'char')
                throw(Exception.ArgumentException('pathToLogFile', 'char'))
            end
            
            persistent localObj;
            if isempty(localObj) || ~isvalid(localObj)
                localObj = Logging.Logger(pathToLogFile);
            end
            obj = localObj;
        end
    end
    
    methods
        function setFilename(obj, logPath)
            [fid,message] = fopen(logPath, 'a');
            if(fid < 0)
                error(['Problem with supplied logfile path: ' message]);
            end
            fclose(fid);
            obj.FullPath = logPath;
        end
        
        function setCommandWindowLevel(obj, loggerIdentifier)
            obj.CommandWindowLevel = loggerIdentifier;
        end
        
        function setLogLevel(obj, logLevel)
            if ~isa(logLevel, 'Logging.Enum.LoggingLevelEnum')
                throw(Exception.ArgumentException('logLevel', 'Logging.Enum.LoggingLevelEnum'))
            end
            obj.LogLevel = logLevel;
        end
        
        function trace(obj, functionName, logMessage)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.TRACE, functionName, logMessage);
        end
        
        function debug(obj, functionName, logMessage)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.DEBUG,functionName,logMessage);
        end
        
        function info(obj, functionName, logMessage)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO,functionName,logMessage);
        end
        
        function warn(obj, functionName, logMessage)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.WARN,functionName,logMessage);
        end
        
        function error(obj, functionName, logMessage)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.ERROR,functionName,logMessage);
        end
        
        function fatal(obj, functionName, logMessage)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.FATAL, functionName, logMessage);
        end
        
        function startMessage(obj, functionName, processName)
            logMessage = ['Starting ', processName];
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, functionName, logMessage)
        end
        
        function progressMessage(obj, functionName, index, numberOfEntries)
            logMessage = ['Finished Image # ', num2str(index),' of ', num2str(numberOfEntries)];
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, functionName, logMessage)
        end
        
        function finishedMessage(obj, functionName, processName)
            logMessage = ['Finished ', processName];
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, functionName, logMessage)
        end
        
        function writeLogo(obj)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, 'Start', 'ImageRefiner - A Matlab Toolbox for refining nephrological images, RWTH Aachen University');
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, 'Start', ['Started at ', char(datetime('now'))]);
        end
        
        function writeVersion(obj)
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, 'VersionCheck', ['Release Version: ', Settings.RELEASE_VERSION]);
            obj.writeLog(Logging.Enum.LoggingLevelEnum.INFO, 'VersionCheck', 'Please check if your local version is up to date in case of unexpected behaviour!');
        end
    end
    
    methods (Access = private)
        function obj = Logging.Logger(fullPathPassed)
            if nargin < 1
                throw(Exception.NoSuchFlowException())
            end
            path = fullPathPassed;
            obj.setFilename(path);
        end
        
        function writeLog(obj, level, scriptName, message)
            % If necessary write to command window
            if( obj.CommandWindowLevel <= level )
                fprintf('%s : %s\n', scriptName, message);
            end
            %If currently set log level is too high, just skip this log
            if(obj.LogLevel > level)
                return;
            end
            % set up our level string
            levelStr = obj.LogLevel.toString();
            % Append new log to log file
            try
                fid = fopen(obj.FullPath, 'a');
                fprintf(fid,'%s %s %s - %s\r\n', datestr(now,'yyyy-mm-dd HH:MM:SS'),...
                    levelStr, scriptName, message);
                fclose(fid);
            catch exception
                disp(exception.getReport());
            end
        end
    end
end

