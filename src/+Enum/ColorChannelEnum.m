classdef ColorChannelEnum
    %ColorChannelEnum Enumeration class for color channels in a given tiff image.
    
    enumeration
        CHANNEL_1
        CHANNEL_2
        CHANNEL_3
        CHANNEL_4
        UNCLASSIFIED
    end
    
    methods(Static)
        function obj = classify(name)
            if Utility.Common.String.endsWith(name, 'CH1')
                obj = Enum.ColorChannelEnum.CHANNEL_1;
            elseif Utility.Common.String.endsWith(name, 'CH2')
                obj = Enum.ColorChannelEnum.CHANNEL_2;
            elseif Utility.Common.String.endsWith(name, 'CH3')
                obj = Enum.ColorChannelEnum.CHANNEL_3;
            elseif Utility.Common.String.endsWith(name, 'CH4')
                obj = Enum.ColorChannelEnum.CHANNEL_4;
            else
                obj = Enum.ColorChannelEnum.UNCLASSIFIED;
            end
        end
    end
    
    methods
        function name = toString(obj)
            switch obj
                case Enum.ColorChannelEnum.CHANNEL_1
                    name = '_CH1';
                case Enum.ColorChannelEnum.CHANNEL_2
                    name = '_CH2';
                case Enum.ColorChannelEnum.CHANNEL_3
                    name = '_CH3';
                case Enum.ColorChannelEnum.CHANNEL_4
                    name = '_CH4';
                case Enum.ColorChannelEnum.UNCLASSIFIED
                    throw(Exception.NoSuchFlowException())
            end
        end          
    end
end

