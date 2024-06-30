classdef TableUnitTest < Test.AbstractTestCase
    % Unit tests for the Utility functions in Utility.Common.Table
    methods(Test)
        function getAllHeadersInvalidInput(testCase)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(testCase.STRING), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()Utility.Common.Table.getAllHeaders(testCase.MAP), testCase.ArgumentException)
        end
    end
end