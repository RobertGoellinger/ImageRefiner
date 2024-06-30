classdef ImageDtoUnitTest < Test.AbstractTestCase
    % Unit tests for DTO.ImageDto
    properties (Access = public, Constant)
        Type = Enum.TypeEnumeration.CORTEX;
        ColorChannel = Enum.ColorChannelEnum.CHANNEL_2;
        Table = table();
        IDENTIFIER = 'identifier';
    end
    
    methods(Test)
        % Constructor
        function imageDtoConstructorInvalidInput(testCase)
            testCase.verifyError(@()DTO.ImageDto(), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(1), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(struct()), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto({'a'}), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(false), testCase.ArgumentException)
            
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER), testCase.NotEnoughInputArguments)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 1), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, struct()), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, {'a'}), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, false), testCase.ArgumentException)
            
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name'), testCase.NotEnoughInputArguments)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', 'type'), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', 1), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', struct()), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', {'a'}), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', false), testCase.ArgumentException)
            
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type), testCase.NotEnoughInputArguments)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, 'type'), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, 1), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, struct()), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, {'a'}), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, false), testCase.ArgumentException)
            
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, testCase.ColorChannel), testCase.NotEnoughInputArguments)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, testCase.ColorChannel, 1), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, testCase.ColorChannel, struct()), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, testCase.ColorChannel, {'a'}), testCase.ArgumentException)
            testCase.verifyError(@()DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, testCase.ColorChannel, false), testCase.ArgumentException)
        end
        
        function imageDtoConstructorCorrect(testCase)
            testCase.verifyClass(DTO.ImageDto(testCase.IDENTIFIER, 'name', testCase.Type, testCase.ColorChannel, 'relative\Path', testCase.), 'DTO:ImageDto')
        end
        
        function imageDtoConstructorIncorrect(testCase)
            
        end
            
        function addCappilaryTableInvalidInput(testCase)
            
        end
        
        function addCappilaryTableCorrect(testCase)
            
        end
        
        function addCappilaryTableIncorrect(testCase)
            
        end
        
        
            
    end
end