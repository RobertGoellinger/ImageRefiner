classdef Java
    %Java Wrapper class for different Java utility functions
    
    methods(Access = public, Static)
        function jreVersion = getJAVARuntimeEnvironmentVersion()
            jreVersion = version('-java')
        end
        
        function uuid = generateUUID()
            uuidJava = javaMethod('toString', java.util.UUID.randomUUID);
            uuid = char(uuidJava);
        end
    end
end

