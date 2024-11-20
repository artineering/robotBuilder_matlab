classdef Axis < urdf.URDFTag
    methods
        function obj = Axis(x, y, z)
            obj@urdf.URDFTag('axis');
            obj.addAttribute('xyz', sprintf('%s %s %s', x, y, z));
        end
        
        function reset(obj, x, y, z)
            obj.attributes('xyz') = sprintf('%s %s %s', x, y, z);
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            xyz = node.getAttribute('xyz');
            xyz_s = xyz.split(' ');
            obj = urdf.Axis(str2double(xyz_s(1)),...
                str2double(xyz_s(2)),...
                str2double(xyz_s(3)));
        end
    end
end

