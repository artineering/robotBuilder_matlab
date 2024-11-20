classdef Joint < urdf.URDFTag
    %JOINT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        jointType
        origin
        parentLink
        child
    end
    
    methods
        function obj = Joint(name, jointType, parentName, childName, origin)
            obj@urdf.URDFTag('joint', name);
            obj.addAttribute('type', jointType);
            obj.parentLink = urdf.URDFTag('parent');
            if exist("parentName", 'var')
                obj.parentLink.addAttribute('link', parentName);
            end

            obj.child = urdf.URDFTag('child');
            if exist("childName", "var")
                obj.child.addAttribute('link', childName);
            end

            if exist("origin", "var")
                obj.origin = origin;
            else
                obj.origin = urdf.Origin();
            end

            obj.addChild(obj.parentLink);
            obj.addChild(obj.child);
            obj.addChild(obj.origin);
        end

        function addParentLink(obj, parentName)
            obj.parentLink.addAttribute('link', parentName);
        end

        function addChildLink(obj, childName)
            obj.child.addAttribute('link', childName)
        end

        function setOrigin(obj, roll, pitch, yaw, x, y, z)
            found = false;
            if numEntries(obj.children) > 0
                childKeys = keys(obj.children);
                for index = 1:numel(childKeys)
                    if isa(obj.children(childKeys(index)), 'urdf.Origin')
                        found = true;
                        obj.children(childKeys(index)).reset(roll, pitch, yaw, x, y, z);
                    end
                end
            end
            if ~found
                obj.addChild(urdf.Origin(roll, pitch, yaw, x, y, z));
            end
        end

        function setOriginObj(obj, origin)
            found = false;
            if numEntries(obj.children) > 0
                childKeys = keys(obj.children);
                for index = 1:numel(childKeys)
                    if isa(obj.children(childKeys(index)), 'urdf.Origin')
                        found = true;
                        obj.children(childKeys(index)) = origin;
                    end
                end
            end
            if ~found
                obj.addChild(origin);
            end
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

