classdef (Abstract) AbstractTestCase < matlab.unittest.TestCase
    %ABSTRACTTESTCASE: Parent class for all test cases
    properties (Access = public, Constant)
        % Test properties
        CELL = {'test', 'Test'};
        STRING = 'test';
        DOUBLE = 42;
        LOGICAL = true;
        STRUCT = struct();
        MAP = containers.Map();
        
        
        % Exception Strings
        NotEnoughInputArguments = 'MATLAB:minrhs';
        ArgumentException = 'ImageRefinement:ArgumentException';
        LogicalErrorException = 'ImageRefinement:LogicalErrorException';
        DirectoryNotFoundException = 'ImageRefinement:DirectoryNotFoundException';
    end
    
end
        