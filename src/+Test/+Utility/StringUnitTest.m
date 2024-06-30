classdef StringUnitTest < Test.AbstractTestCase
    % Unit tests for the Utility functions in Utility.Common.String
    properties (Access = public, Constant)
        TARGET_PATH = 'C:\git\imagerefiner\target';
        TEST_STRING = 'abc';
    end
    
    methods(Test)
        function splitPathInvalidInput(testCase)
            testCase.verifyError(@()Utility.Common.String.splitPath(), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.splitPath(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.splitPath(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.splitPath(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.splitPath(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.splitPath(testCase.MAP), testCase.ArgumentException)
        end
        
        function splitPathCorrect(testCase)
            testCase.verifyEqual(Utility.Common.String.splitPath(testCase.TARGET_PATH), {'C:', 'git', 'imagerefiner', 'target'})
        end
        
        function splitPathIncorrect(testCase)
            testCase.verifyNotEqual(Utility.Common.String.splitPath(testCase.TARGET_PATH), {'C:', 'git', 'imagerefiner'})
            testCase.verifyNotEqual(Utility.Common.String.splitPath(testCase.TARGET_PATH), {'C:', 'git', 'imagerefiner', 2})
            testCase.verifyNotEqual(Utility.Common.String.splitPath(testCase.TARGET_PATH), {})
        end
        
        function cutOffSubstringInvalidInput(testCase)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.MAP), testCase.ArgumentException)
            
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, testCase.MAP), testCase.ArgumentException)
        end
        
        function cutOffSubstringCorrect(testCase)
            testCase.verifyEqual(Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, 'c'), 'ab')
            testCase.verifyEqual(Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, 'bc'), 'a')
            testCase.verifyEqual(Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, 'b'), 'a')
            testCase.verifyError(@()Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, 'd'), testCase.LogicalErrorException)
        end
        
        function cutOffSubstringIncorrect(testCase)
            testCase.verifyNotEqual(Utility.Common.String.cutOffSubstring(testCase.TEST_STRING, 'bc'), 'ab')
        end
    end
end

