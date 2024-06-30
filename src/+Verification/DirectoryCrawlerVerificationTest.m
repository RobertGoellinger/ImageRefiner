classdef DirectoryCrawlerVerificationTest < matlab.unittest.TestCase
    %DirectoryCrawlerVerificationTest: A class to specify verification
    %tests
    
    methods (Test)
        function correctSetup(testCase)
            testCase.verifyClass();
        end
    end
end

