classdef TypeEnumerationUnitTest < Test.AbstractTestCase
    % Unit tests for Enum.TypeEnumeration
    
    properties (Access = public, Constant)
        Cortex = Enum.TypeEnumeration.CORTEX;
        Medulla = Enum.TypeEnumeration.MEDULLA;
        Unclassified = Enum.TypeEnumeration.UNCLASSIFIED;
        TYPE_ENUMERATION_CLASS = 'Enum.TypeEnumeration';
    end
    
    methods(Test)
        % Constructor
        function toStringCorecct(testCase)
            testCase.verifyClass(testCase.Cortex, testCase.TYPE_ENUMERATION_CLASS)
            testCase.verifyEqual(testCase.Cortex.toString(), 'Cortex')
            testCase.verifyEqual(testCase.Medulla.toString(), 'Medulla')
            testCase.verifyEqual(testCase.Unclassified.toString(), 'Unclassified')
        end
        
        function toStringIncorrect(testCase)
            testCase.verifyNotEqual(testCase.Cortex.toString(), 'Medulla')
            testCase.verifyNotEqual(testCase.Medulla.toString(), 'Cortex')
            testCase.verifyNotEqual(testCase.Unclassified.toString(), 'Medulla')
        end
        
        function classifyTypeInvalidInput(testCase)
            testCase.verifyError(@()Enum.TypeEnumeration.classifyType(), testCase.ArgumentException)
            testCase.verifyError(@()Enum.TypeEnumeration.classifyType(testCase.CELL), testCase.ArgumentException)
            testCase.verifyError(@()Enum.TypeEnumeration.classifyType(testCase.STRUCT), testCase.ArgumentException)
            testCase.verifyError(@()Enum.TypeEnumeration.classifyType(testCase.MAP), testCase.ArgumentException)
            testCase.verifyError(@()Enum.TypeEnumeration.classifyType(testCase.LOGICAL), testCase.ArgumentException)
        end
        
        function classifyTypeCorrect(testCase)
            testCase.verifyClass(Enum.TypeEnumeration.classifyType('Cortex'), testCase.TYPE_ENUMERATION_CLASS)
            testCase.verifyEqual(Enum.TypeEnumeration.classifyType('Cortex'), testCase.Cortex)
            testCase.verifyEqual(Enum.TypeEnumeration.classifyType('Medulla'), testCase.Medulla)
            testCase.verifyEqual(Enum.TypeEnumeration.classifyType('Unclassified'), testCase.Unclassified)
        end
        
        function classifyTypeIncorrect(testCase)
            testCase.verifyNotEqual(Enum.TypeEnumeration.classifyType('Cortex'), testCase.Medulla)
            testCase.verifyNotEqual(Enum.TypeEnumeration.classifyType('Medulla'), testCase.Cortex)
            testCase.verifyNotEqual(Enum.TypeEnumeration.classifyType('Unclassified'), testCase.Cortex)
        end 
    end
end