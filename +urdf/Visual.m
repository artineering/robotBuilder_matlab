classdef Visual < urdf.URDFTag
    %VISUAL class represents the visual component of the link node
    properties
        geometry
        origin
    end
    
    methods
        function obj = Visual()
            obj@urdf.URDFTag('visual');
            obj.geometry = urdf.Geometry();
            obj.origin = urdf.Origin();
            obj.addChild(obj.geometry);
            obj.addChild(obj.origin);
        end

        function addVisualComponent(obj, element)
            obj.geometry.addVisualComponent(element);
        end

        function setOrigin(obj, roll, pitch, yaw, x, y, z)
            obj.origin.reset(roll, pitch, yaw, x, y, z);
        end

        function setOriginObj(obj, origin)
            obj.origin = origin;
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            obj = urdf.Visual();
            for i = 0:(node.getLength()-1)
                child = node.item(i);
                switch char(child.getNodeName())
                    case 'geometry'
                        obj.geometry = urdf.Geometry.buildFromURDF(child);
                    case 'origin'
                        obj.setOriginObj(urdf.Origin.buildFromURDF(child));
                end
            end
        end
    end
end

