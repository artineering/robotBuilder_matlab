classdef Geometry < urdf.URDFTag
    %GEOMETRY Summary of this class goes here
    %   Detailed explanation goes here
    
    methods
        function obj = Geometry()
            %GEOMETRY Construct an instance of this class
            obj@urdf.URDFTag('geometry');
        end
        
        function addVisualComponent(obj, element)
            obj.addChild(element);
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            obj = urdf.Geometry();
             for i = 0:(node.getLength()-1)
                child = node.item(i);
                if strcmp(char(child.getNodeName()), 'cylinder')
                    obj.addVisualComponent(urdf.shapes.Cylinder.buildFromURDF(child));
                end    
             end
        end
    end
end

