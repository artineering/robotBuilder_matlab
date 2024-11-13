classdef Cylinder < urdf.URDFTag
    %CYLINDER Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = Cylinder(radius, length)
            obj@urdf.URDFTag('cylinder');
            obj.addAttribute('radius', num2str(radius));
            obj.addAttribute('length', num2str(length));
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            radius = node.getAttribute('radius');
            length = node.getAttribute('length');
            obj = urdf.shapes.Cylinder(str2double(radius), str2double(length));
        end
    end
end


