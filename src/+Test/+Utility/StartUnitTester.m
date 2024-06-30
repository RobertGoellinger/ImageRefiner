function result = StartUnitTester(~, reportPath, coveragePath)
%StartUnitTester Start Unit tests
if nargin < 2
    reportPath = [];
end
if nargin < 3
    coveragePath = [];
end

testSuite = Test.TestFramework.Testsuites();
unitTestPerformer = Test.TestFramework.Performer('Utility', testSuite);
unitTestPerformer.ReportPath = reportPath; 
unitTestPerformer.CoveragePath = coveragePath;
result = unitTestPerformer.run();
end

