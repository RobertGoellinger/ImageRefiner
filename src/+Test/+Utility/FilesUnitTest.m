classdef FilesUnitTest < Test.AbstractTestCase
    % Unit tests for the Utility functions in Utility.Common.Files
    methods(Test)
        % isValidDirectory
        function isValidFileNameInvalidInput(testCase)
            testCase.verifyError(@()Utility.Common.Files.isValidFileName(), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Files.isValidFileName(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Files.isValidFileName(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Files.isValidFileName(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Files.isValidFileName(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Files.isValidFileName(testCase.MAP), testCase.ArgumentException)
        end
        
        function isValidFileNameCorrect(testCase)
            testCase.verifyTrue(Utility.Common.Files.isValidFileName('40fach_CH2.tif'))
        end
        
        function isValidFileNameIncorrect(testCase)
            testCase.verifyFalse(Utility.Common.Files.isValidFileName('._40fach.tif'))
            testCase.verifyFalse(Utility.Common.Files.isValidFileName('40fach.tif'))
        end
    end
end
