classdef Builder
    %URDFBUILDER URDFBuilder helps building a robot model using the urdf
    %format.
    %   The URDFBuilder can be used to build a robot model using a
    %   step-by-step construction process, by defining links, geometries,
    %   joints etc. Once all the elements have been added, the model can be
    %   compiled into a .urdf file that can be loaded onto Gazebo and used
    %   for simulations.
    
    properties
        Property1
    end
    
    methods
        function obj = Builder(inputArg1,inputArg2)
            %URDFBUILDER Construct an instance of this class
            %   Detailed explanation goes here
            obj.Property1 = inputArg1 + inputArg2;
        end
        
        function outputArg = method1(obj,inputArg)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            outputArg = obj.Property1 + inputArg;
        end
    end
end

