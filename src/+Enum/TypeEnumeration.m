classdef TypeEnumeration
    % TYPEENUMERATION Classification for Images in the two categories Cortex
    % and medulla
    
    enumeration
        CORTEX
        MEDULLA
        UNCLASSIFIED
    end
    
    methods (Access = public)
        function name = toString(obj)
            switch obj
                case Enum.TypeEnumeration.CORTEX
                    name = 'Cortex';
                case Enum.TypeEnumeration.MEDULLA
                    name = 'Medulla';
                case Enum.TypeEnumeration.UNCLASSIFIED
                    name = 'Unclassified';
                otherwise
                    throw(Exception.NoSuchFlowException())
            end
        end
    end
    
    methods(Access = public, Static)
        function enum = classifyType(name)
            if nargin < 1 || ~isa(name, 'char')
                throw(Exception.ArgumentException('name', 'char'))
            end
            
            switch name
                case 'Cortex'
                    enum = Enum.TypeEnumeration.CORTEX;
                case 'Medulla'
                    enum = Enum.TypeEnumeration.MEDULLA;
                otherwise
                    enum = Enum.TypeEnumeration.UNCLASSIFIED;
            end
        end
    end
end

