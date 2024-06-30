classdef CellUnitTest < Test.AbstractTestCase
    % Unit tests for the Utility functions in Utility.Common.Cell
    methods(Test)
        function containsInvalidInput(testCase)
            testCase.verifyError(@()Utility.Common.Cell.contains(), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.STRING), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.MAP), testCase.ArgumentException)
            
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.CELL, testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.CELL, testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.CELL, testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.CELL, testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Cell.contains(testCase.CELL, testCase.MAP), testCase.ArgumentException)
        end
        
        function containsCorrect(testCase)
            testCase.verifyEqual(Utility.Common.Cell.contains(testCase.CELL, 'test'))
            testCase.verifyEqual(Utility.Common.Cell.contains(testCase.CELL, 'Test'))
            testCase.verifyNotEqual(Utility.Common.Cell.contains(testCase.CELL, 'est'))
        end
    end
end