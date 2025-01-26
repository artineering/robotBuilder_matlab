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
            node = urdf.util.findNodeFromRobotRoot(obj.shadowTag, [convertStringsToChars(obj.shadowTag.getName()) '.' targetPath]);
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
            paramRef = struct('targetPath', targetPath,...
                'propertyName', propertyName,...
                'paramName', paramName);
            obj.parameterRefs = insert(obj.parameterRefs, paramName, paramRef);
        end

        function instanceRobot = applyParametersToInstance(obj, instanceRobot, parameters)
            if ~isempty(parameters) && ~isConfigured(obj.parameters)
                error(['No parameters were configured for ' obj.name]);
            end
            for i = 1:numel(parameters)
                param = parameters(i);
                if isempty(fieldnames(lookup(obj.parameters, param.paramName, "FallbackValue", struct)))
                    error(['Parameter ' param.paramName ' is not defined for ' obj.name]);
                end
                if isConfigured(obj.parameterRefs)
                    if isempty(fieldnames(lookup(obj.parameterRefs, param.paramName, "FallbackValue", struct)))
                        error(['No mapping was provided for ' param.paramName]);
                    else
                        paramRef = obj.parameterRefs(param.paramName);
                        node = urdf.util.findNodeFromRobotRoot(instanceRobot,...
                            [convertStringsToChars(instanceRobot.getName()) '.' paramRef.targetPath]);
                        if urdf.util.isNullTag(node)
                            error(['No child with path ' targetPath ' found in ' obj.name]);
                        end
                        % Verify if the property name is valid for the target node
                        % found.
                        if ~node.hasAttribute(paramRef.propertyName)
                            error(['No property with name ' paramRef.propertyName ' found in ' node.getName()]);
                        end
                        node.addAttribute(paramRef.propertyName, paramRef.value);
                    end
                else
                    error(['Parameter references not created for ' obj.name]);
                end
            end
        end

        function outputArg = serialize(obj)
            outputArg = obj.shadowTag.serialize();
        end

        function robot = createInstance(obj, robot, instanceName, parameters)
            % Check if instance name already exists in robot
            searchPattern = ['^' regexptranslate('escape', instanceName) '.*'];
            options = struct('regularExpression', true);
            existingNodes = urdf.util.findNodesByPattern(robot, searchPattern, options);
            
            if ~isempty(existingNodes)
                error('URDF:Component:DuplicateInstance', ...
                      'Robot already contains nodes with prefix "%s"', instanceName);
            end

            % Validate parameters


            % Create instance copy of the shadow robot.
            instanceRobot = obj.shadowTag.clone();
            
            % Apply the parameters to the instanceRobot children.
            parameterizedRobot = obj.applyParametersToInstance(instanceRobot, parameters);
                        
            % Apply the instance name prefix to all the children
            parameterizedRobot.addPrefixToChildren(instanceName);

            % Merge the parameterized robot nodes with the robot.
            robot.merge(parameterizedRobot);
        end
    end
end

