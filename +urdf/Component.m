classdef Component < handle
    %COMPONENT Component class represents a reusable set of links and
    %joints. Use the Component class to build a reusable part of a robot
    %and then instantiate multiple copies of the component with unique
    %instance names to add to the robot. User can also serialize and save
    %the component in a separate URDF file.
    properties
        name
        shadowTag;
        links
        joints
        parameters
        parameterRefs
    end
    methods
        function obj = Component(componentName)
            obj.name = componentName;
            obj.shadowTag = urdf.Robot(['shadow_' componentName]);
            obj.parameters = configureDictionary('char', 'struct');
            obj.parameterRefs = configureDictionary('char', 'struct');
        end

        function addLink(obj, link)
            obj.shadowTag.addLink(link);
        end

        function removeLink(obj, linkName)
            obj.shadowTag.remove(obj.links, linkName);
        end

        function link = getLink(obj, linkName)
            link = obj.shadowTag.getLink(linkName);
        end

        function addJoint(obj, joint)
            obj.shadowTag.addJoint(joint);
        end

        function removeJoint(obj, jointName)
            obj.shadowTag.removeJoint(jointName);
        end

        function joint = getJoint(obj, jointName)
            joint = obj.shadowTag.getJoint(jointName);
        end

        function defineParameter(obj, paramName, defaultValue, description)
            % Define a new parameter for the component
            % Args:
            %   paramName: Name of the parameter
            %   defaultValue: Default value for the parameter
            %   description: Description of what the parameter controls
            
            param = struct('name', paramName, ...
                          'default', defaultValue, ...
                          'description', description);
            obj.parameters = insert(obj.parameters, paramName, param);
        end

        function attachParameter(obj, paramName, targetPath, propertyName)
            % Verify if the paramName is valid.
            if ~isConfigured(obj.parameters)
                error(['No parameters were configured for ' obj.name]);
            end
            if isempty(fieldnames(lookup(obj.parameters, paramName, "FallbackValue", struct)))
                error(['Parameter ' paramName ' is not defined for ' obj.name]);
            end
            % Verify if the targetPath is a valid node in the shadow robot.
            node = urdf.util.findNodeFromRobotRoot(obj.shadowTag, targetPath);
            if urdf.util.isNullTag(node)
                error(['No child with path ' targetPath ' found in ' obj.name]);
            end
            % Verify if the property name is valid for the target node
            % found.
            if ~node.hasAttribute(propertyName)
                error(['No property with name ' propertyName ' found in ' node.getName()]);
            end

            % Add the target node and property to the parameter reference
            % list.
            paramRef = struct('node', node,...
                'propertyName', propertyName,...
                'paramName', paramName);
            obj.parameterRefs = insert(obj.parameterRefs, paramName, paramRef);
        end

        function outputArg = serialize(obj)
            outputArg = obj.shadowTag.serialize();
        end

        function robot = createInstance(obj, robot, instanceName, parameters)
            % Validate instance does not clash with existing nodes in the
            % robot structure

            % Validate parameters

            % Get all nodes from the component
            % For each node
            %   Apply parameters to the node if applicable
            %   Apply instance name prefix
            %   Insert modified node into robot
        end
    end
end

