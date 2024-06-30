classdef PathUnitTest < Test.AbstractTestCase
    % Unit tests for the Utility functions in Utility.Common.Path
    methods(Test)
        % isValidDirectory
        function isValidDirectoryInvalidInput(testCase)
            testCase.verifyError(@()Utility.Common.Path.isValidDirectory(), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Path.isValidDirectory(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Path.isValidDirectory(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Path.isValidDirectory(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Path.isValidDirectory(testCase.MAP), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Path.isValidDirectory(testCase.STRUCT), testCase.ArgumentException)
        end
        
        function isValidDirectoryCorrect(testCase)
            
        end
        
        function isValidDirectoryIncorrect(testCase)

        end
        
        % getName
        function getNameInvalidInput(testCase)
            
        end
        
        function getNameCorrect(testCase)
            
        end
        
        function getNameIncorrect(testCase)
            
        end
        
        % getExtension
        function getExtensionInvalidInput(testCase)
            
        end
        
        function getExtensionCorrect(testCase)
            
        end
        
        function getExtensionIncorrect(testCase)
            
        end
        
        % getDirectory
        function getDirectoryInvalidInput(testCase)
            
        end
        
        function getDirectoryCorrect(testCase)
            
        end
        
        function getDirectoryIncorrect(testCase)
            
        end        
    end
end