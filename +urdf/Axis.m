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
end

