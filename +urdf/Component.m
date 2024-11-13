classdef Component < urdf.URDFTag
    %COMPONENT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        instance_identifier
    end
    
    methods
        function obj = Component(componentName, instance_identifier, params)
            obj@urdf.URDFTag('xacro:macro', componentName);
            obj.instance_identifier = instance_identifier;
            obj.addAttributes(params);
        end
    end
end

