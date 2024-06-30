classdef ImageAnalyzerUnitTest < Test.AbstractTestCase
    % Unit tests for ImageAnalyzer 
    properties (Access = public, Constant)
        ImageDtoCollection = {};
        IMAGE_ANALYZER_CLASS = 'ImageHandler.ImageAnalyzer';
    end
    
    methods(Test)
        % Check for valid constructor
        function imageAnalyzerInvalidInput(testCase)
            testCase.verifyError(@()ImageHandler.ImageAnalyzer(), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.ImageAnalyzer(testCase.DOUBLE), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.ImageAnalyzer(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.ImageAnalyzer(testCase.LOGICAL), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.ImageAnalyzer(testCase.MAP), testCase.ArgumentException)
            testCase.verifyError(@()ImageHandler.ImageAnalyzer(testCase.CELL), testCase.ArgumentException)
        end
        
        function imageAnalyzerCorrect(testCase)
            testCase.verifyClass(ImageHandler.ImageAnalyzer(testCase.ImageDtoCollection), 'ImageHandler.ImageAnalyzer')
        end
    end
end