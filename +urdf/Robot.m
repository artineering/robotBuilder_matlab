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
            obj.links = dictionary;
            obj.joints = dictionary;
        end

        function newRobot = clone(obj)
            urdf.util.writeToURDFFile(obj, 'tempFile.urdf');
            newRobot = urdf.Robot.buildFromURDF('tempFile.urdf');
            delete tempFile.urdf;
        end
        
        function addLink(obj, link)
            obj.links(link.getName()) = {link};
        end

        function removeLink(obj, linkName)
            obj.links = remove(obj.links, linkName);
        end

        function link = getLink(obj, linkName)
            link = obj.links(linkName);
            if isa(link, 'cell')
                link = link{1};
            end
        end

        function addJoint(obj, joint)
            obj.joints(joint.getName()) = {joint};
        end

        function removeJoint(obj, jointName)
            remove(obj.joints, jointName);
        end

        function joint = getJoint(obj, jointName)
            joint = obj.joints(jointName);
            if isa(joint, 'cell')
                joint = joint{1};
            end
        end

        function configureJoint(obj, jointName, lower, upper, effort, velocity)
            joint = obj.getJoint(jointName);
            joint.setLimits(lower, upper);
            joint.setEffort(effort);
            joint.setVelocity(velocity);
        end

        function addPrefixToChildren(obj, prefix)            
            % Input validation
            validateattributes(prefix, {'char', 'string'}, {'scalartext'}, 'addPrefix', 'prefix');
            
            % Collect all original names for reference updating
            nameMap = containers.Map('KeyType', 'char', 'ValueType', 'char');
            
            % Update link names
            if isConfigured(obj.links)
                linkKeys = keys(obj.links);
                for i = 1:numel(linkKeys)
                    link = obj.getLink(linkKeys{i});
                    oldName = link.getName();
                    newName = strcat(prefix, "_", oldName);
                    
                    % Store name mapping for joint reference updates
                    nameMap(oldName) = newName;
                    
                    % Update link name
                    if link.useName
                        link.attributes('name') = newName;
                    else
                        link.name = newName;
                    end
                    
                    % Update link key in robot's links map
                    obj.removeLink(oldName);
                    obj.addLink(link);
                end
            end
            
            % Update joint names and references
            if isConfigured(obj.joints)
                jointKeys = keys(obj.joints);
                for i = 1:numel(jointKeys)
                    joint = obj.getJoint(jointKeys{i});
                    oldName = joint.getName();
                    newName = strcat(prefix, "_", oldName);
                    
                    % Update joint name
                    if joint.useName
                        joint.attributes('name') = newName;
                    else
                        joint.name = newName;
                    end
                    
                    % Update parent link reference
                    if isa(joint.parentLink, 'urdf.URDFTag') && joint.parentLink.hasAttribute('link')
                        parentName = joint.parentLink.attributes('link');
                        if nameMap.isKey(parentName)
                            joint.parentLink.attributes('link') = nameMap(parentName);
                        end
                    end
                    
                    % Update child link reference
                    if isa(joint.child, 'urdf.URDFTag') && joint.child.hasAttribute('link')
                        childName = joint.child.attributes('link');
                        if nameMap.isKey(childName)
                            joint.child.attributes('link') = nameMap(childName);
                        end
                    end
                    
                    % Update joint key in robot's joints map
                    obj.removeJoint(oldName);
                    obj.addJoint(joint);
                end
            end
        end

        function merge(obj, otherRobot)
            if isConfigured(otherRobot.links)
                linkKeys = keys(otherRobot.links);
                for i = 1:numel(linkKeys)
                    link = otherRobot.getLink(linkKeys{i});
                    obj.addLink(link);
                end
            end
            if isConfigured(otherRobot.joints)
                jointKeys = keys(otherRobot.joints);
                for i = 1:numel(jointKeys)
                    joint = otherRobot.getJoint(jointKeys{i});
                    obj.addJoint(joint);
                end
            end
            % Merge material and other nodes here.
            % TO DO
        end

        function outputArg = serialize(obj)
            obj.resetChildren();
            obj.populateChildren();
            outputArg = serialize@urdf.URDFTag(obj);
        end

        function populateFromXML(obj, node)
            for i = 0:(node.getLength()-1)
                child = node.item(i);
                switch char(child.getNodeName())
                    case 'link'
                        obj.addLink(urdf.Link.buildFromURDF(child));
                    case 'joint'
                        obj.addJoint(urdf.Joint.buildFromURDF(child));
                end
            end
        end

        function success = applyParameterValue(obj, path, value)
            % Apply parameter value to specified path in robot
            try
                pathParts = strsplit(path, '.');
                node = obj;

                % Since the first part of the path has to be a named
                % element, we can search for it first.
                node = node.findChild('urdf.URDFTag',pathParts{1});
                if isa(node, 'cell')
                    node = node{1};
                end
                
                % Navigate path
                for i = 2:length(pathParts)-1
                    temp = node.findChild(pathParts{i});
                    if isa(temp, 'cell')
                        node = temp{1};
                    end
                end
                
                % Set value
                node.addAttribute(pathParts{end}, value);
                success = true;
            catch
                success = false;
            end
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
            robot.populateFromXML(node);
        end
    end
end

