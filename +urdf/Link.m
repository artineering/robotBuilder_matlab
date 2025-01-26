classdef Link < urdf.URDFTag
    %LINK class represents the LINK node in the URDF file.
    %   Link node represents a physical element in the robot.
    properties
        visual
        collision
    end
    methods
        function obj = Link(name)
            obj@urdf.URDFTag('link', name);
            obj.visual = urdf.Visual();
            obj.collision = urdf.Collision();
        end

        function addChild(obj, child)
            if ~isa(child, "urdf.Visual") && ~isa(child, "urdf.Collision")
                error("Invalid child for a Link node");
            end
            addChild@urdf.URDFTag(obj, child);
        end

        function addVisual(obj, element)
            obj.visual.addVisualComponent(element);
        end

        function addCollision(obj, element)
            obj.collision.addVisualComponent(element);
        end

        function setOrigin(obj, roll, pitch, yaw, x, y, z)
            obj.visual.setOrigin(roll, pitch, yaw, x, y, z);
            obj.collision.setOrigin(roll, pitch, yaw, x, y, z);
        end

        function outputArg = serialize(obj)
            obj.clearChildren();
            obj.addChild(obj.visual);
            obj.addChild(obj.collision);
            outputArg = serialize@urdf.URDFTag(obj);
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
                elseif strcmp(child.getNodeName(), 'collision')
                    obj.collision = urdf.Collision.buildFromURDF(child);
                end
            end
        end
    end
end

