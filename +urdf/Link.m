classdef Link < urdf.URDFTag
    %LINK class represents the LINK node in the URDF file.
    %   Link node represents a physical element in the robot.
    properties
        visual
    end
    methods
        function obj = Link(name)
            obj@urdf.URDFTag('link', name);
            obj.visual = urdf.Visual();
            obj.addChild(obj.visual);
        end

        function addVisualComponent(obj, element)
            obj.visual.addVisualComponent(element);
        end

        function setOrigin(obj, roll, pitch, yaw, x, y, z)
            obj.visual.setOrigin(roll, pitch, yaw, x, y, z);
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            linkName = node.getAttribute('name');
            obj = urdf.Link(linkName);
            for i = 0:(node.getLength()-1)
                child = node.item(i);
                if strcmp(child.getNodeName(), 'visual')
                    obj.visual = urdf.Visual.buildFromURDF(child);
                end
            end
        end
    end
end

