classdef Sphere < urdf.URDFTag
    %CYLINDER Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = Sphere(radius)
            obj@urdf.URDFTag('sphere');
            obj.addAttribute('radius', num2str(radius));
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            radius = node.getAttribute('radius');
            obj = urdf.shapes.Cylinder(str2double(radius));
        end
    end
end


