classdef Box < urdf.URDFTag
    %Box Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = Box(x, y, z)
            obj@urdf.URDFTag('box');
            obj.addAttribute('size', sprintf('%s %s %s', x, y, z));
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            size = node.getAttribute('size');
            size = strsplit(size,' ');
            obj = urdf.shapes.Cylinder(str2double(size(1)), str2double(size(2)), str2double(size(3)));
        end
    end
end


