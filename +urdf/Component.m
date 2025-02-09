classdef Component < handle
    properties
        shadowRobot    % Robot object containing component definition
        parameters     % Map of parameter name to {defaultValue, appliesTo} struct
        attachPoint    % Attachment point for the component
        tabs
    end
    
    methods
        function obj = Component(name)
            obj.tabs = 0;
            obj.shadowRobot = urdf.Robot(name);
            obj.parameters = containers.Map('KeyType', 'char', 'ValueType', 'any');
            obj.attachPoint = '';

            % Increment the shadow robot's tabs to indent it by one level.
            obj.shadowRobot.tabs = 1;
        end

        function addLink(obj, link)
            obj.shadowRobot.addLink(link);
        end

        function addJoint(obj, joint)
            obj.shadowRobot.addJoint(joint);
        end
        
        function addParameter(obj, name, defaultValue, appliesTo)
            if obj.parameters.isKey(name)
                error('Parameter %s already exists', name);
            end
            obj.parameters(name) = struct('defaultValue', defaultValue, ...
                                        'appliesTo', appliesTo);
        end
        
        function setAttachPoint(obj, point)
            obj.attachPoint = point;
        end
        
        function targetRobot = createInstance(obj, targetRobot, instanceName, paramValues)
            % Create instance copy
            robotCopy = obj.shadowRobot.clone();
            robotCopy.serialize();
            
            
            % Apply parameter values
            if ~isempty(paramValues)
                paramNames = fieldnames(paramValues);
                for i = 1:numel(paramNames)
                    param = paramNames{i};
                    % Get path and apply value
                    paramDef = obj.parameters(param);
                    path = paramDef.appliesTo;
                    if ~robotCopy.applyParameterValue(path, paramValues.(param))
                        error('Failed to apply parameter %s to path %s', ...
                              param, path);
                    end
                end
            end

            % Add the instance name as prefix to the robot copy nodes.
            robotCopy.addPrefixToChildren(instanceName);
            
            % Merge the robot copy into the target robot.
            targetRobot.merge(robotCopy);
        end
        
        function xml = serialize(obj)
            shadowRobotXML = obj.shadowRobot.serialize();
            
        end
    end
    
    methods(Static)
        function obj = buildFromURDF(node)
            % Create component from XML node
            name = char(node.getAttribute('name'));
            obj = urdf.Component(name);
            
            % Parse parameters
            paramNodes = node.getElementsByTagName('parameter');
            for i = 0:paramNodes.getLength()-1
                paramNode = paramNodes.item(i);
                
                nameNode = paramNode.getElementsByTagName('name').item(0);
                defaultNode = paramNode.getElementsByTagName('defaultValue').item(0);
                appliesToNode = paramNode.getElementsByTagName('appliesTo').item(0);
                
                name = char(nameNode.getTextContent());
                defaultValue = char(defaultNode.getTextContent());
                appliesTo = char(appliesToNode.getTextContent());
                
                obj.addParameter(name, defaultValue, appliesTo);
            end
            
            % Parse attachPoint
            attachNodes = node.getElementsByTagName('attachPoint');
            if attachNodes.getLength() > 0
                attachPoint = char(attachNodes.item(0).getTextContent());
                obj.setAttachPoint(attachPoint);
            end
        end
    end
end