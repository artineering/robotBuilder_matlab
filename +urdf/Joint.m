classdef Joint < urdf.URDFTag
    %JOINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        jointType
        origin
        parentLink
        childLink
    end
    
    methods
        function obj = Joint(name, jointType, parentName, childName, elements)
            arguments (Input)
                % Required properties
                name        (1,1) string
                jointType   (1,1) string
                parentName  (1,1) string
                childName   (1,1) string

                % Optional elements - sub-classes to enforce elements as required.
                elements.origin (1,1) struct = struct('roll', 0, 'pitch', 0, 'yaw', 0, 'x', 0, 'y', 0, 'z', 0)
                elements.axis (1,3) = [1, 0, 1]
                elements.calibration (1,1) struct = struct('rising', [], 'falling', [])
                elements.dynamics (1,1) struct = struct('damping', 0, 'friction', 0)
                elements.limit (1,1) struct = struct('lower', 0, 'upper', 0, 'effort', 0, 'velocity', 0)
                elements.safety_controller (1,1) struct = struct('soft_lower_limit', 0, 'soft_upper_limit', 0, 'k_position', 0, 'k_velocity', 0)
                elements.mimic (1,1) struct = struct('joint', '', 'multiplier', 0, 'offset', 0)
            end

            % Construct the urdftag.
            obj@urdf.URDFTag('joint', name);

            % Set the joint type.
            obj.addAttribute('type', jointType);

            % Configure the parent and child links.
            obj.parentLink = urdf.URDFTag('parent');
            obj.parentLink.addAttribute('link', parentName);
            obj.addChild(obj.parentLink);
            obj.childLink = urdf.URDFTag('child');
            obj.childLink.addAttribute('link', childName);
            obj.addChild(obj.childLink);

            % Add the joint elements.
            obj.addElements(elements)
        end

        function updateParentLink(obj, parentName)
            obj.parentLink.addAttribute('link', parentName);
        end

        function updateChildLink(obj, childName)
            obj.childLink.addAttribute('link', childName)
        end

        function addElements(elements)

        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            type = char(node.getAttribute('type'));
            obj = [];
            switch(type)
                case 'revolute'
                    obj = urdf.joints.Revolute.buildFromURDF(node);
                case 'prismatic'
                    obj = urdf.joints.Prismatic.buildFromURDF(node);
                case 'planar'
                    obj = urdf.joints.Planar.buildFromURDF(node);
                case 'floating'
                    obj = urdf.joints.Floating.buildFromURDF(node);
                case 'fixed'
                    obj = urdf.joints.Fixed.buildFromURDF(node);
                case 'continuous'
                    obj = urdf.joints.Continuous.buildFromURDF(node);
            end
            if ~isempty(obj)
                for i = 0:(node.getLength()-1)
                    child = node.item(i);
                    if strcmp(char(child.getNodeName()), 'origin')
                        obj.setOriginObj(urdf.Origin.buildFromURDF(child));
                    end    
                end
            end
        end
    end
end

