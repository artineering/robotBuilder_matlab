classdef Robot < urdf.URDFTag
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here

    properties
        links
        joints
    end
    
    methods
        function obj = Robot(name)
            obj@urdf.URDFTag('robot', name);
            obj.links = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.joints = containers.Map('KeyType', 'char', 'ValueType', 'any');
        end
        
        function addLink(obj, link)
            obj.links(link.getName()) = link;
        end

        function removeLink(obj, linkName)
            remove(obj.links, linkName);
        end

        function link = getLink(obj, linkName)
            link = obj.links(linkName);
        end

        function addJoint(obj, joint)
            obj.joints(joint.getName()) = joint;
        end

        function removeJoint(obj, jointName)
            remove(obj.joints, jointName);
        end

        function joint = getJoint(obj, jointName)
            joint = obj.joints(jointName);
        end

        function configureJoint(obj, jointName, lower, upper, effort, velocity)
            joint = obj.getJoint(jointName);
            joint.setLimits(lower, upper);
            joint.setEffort(effort);
            joint.setVelocity(velocity);
        end

        function outputArg = serialize(obj)
            obj.resetChildren();
            obj.populateChildren();
            outputArg = serialize@urdf.URDFTag(obj);
        end
    end

    methods(Access = private)
        function resetChildren(obj)
            if isConfigured(obj.children)
                obj.children = remove(obj.children, keys(obj.children));
            end
        end

        function populateChildren(obj)
            linkEntries = values(obj.links);
            jointEntries = values(obj.joints);
            
            for index = 1:numel(linkEntries)
                link = linkEntries{index};
                obj.addChild(link);
            end

            for index = 1:numel(jointEntries)
                joint = jointEntries{index};
                obj.addChild(joint);
            end
        end
    end

    methods(Static)
        function robot = buildFromURDF(filename)
            node = urdf.util.readXML(filename);
            robot = urdf.Robot(node.getAttribute('name'));
            for i = 0:(node.getLength()-1)
                child = node.item(i);
                switch char(child.getNodeName())
                    case 'link'
                        robot.addLink(urdf.Link.buildFromURDF(child));
                    case 'joint'
                        robot.addJoint(urdf.Joint.buildFromURDF(child));
                end
            end
        end
    end
end

