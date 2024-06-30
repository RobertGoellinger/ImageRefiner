classdef DirectoryCrawlerUnitTest < Test.AbstractTestCase
    % Unit tests for the DirectoryCrawler class
    properties (Access = public, Constant)
        DIRECTORY_CRAWLER_CLASS = 'ImageHandler.DirectoryCrawler';
    end
    
    methods(Test)
        % Check for valid constructor
        function directoryCrawlerInvalidInput(testCase)
            testCase.verifyError(@()ImageHandler.DirectoryCrawler(), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.DirectoryCrawler(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.DirectoryCrawler(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.DirectoryCrawler(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.DirectoryCrawler(testCase.MAP), testCase.ArgumentException)            
        end
        
        function directoryCrawlerCorrect(testCase)
            testCase.verifyClass(ImageHandler.DirectoryCrawler(Settings.IMPORT_PATH), 'ImageHandler.DirectoryCrawler')
        end
    end
end
