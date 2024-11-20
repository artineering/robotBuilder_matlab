classdef Floating < urdf.Joint
    %FLOATING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Property1
    end
    
    methods
        function obj = Floating(name, parentLink,childLink)
            obj@urdf.Joint(name, 'floating', parentLink, childLink);
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            name = char(node.getAttribute('name'));
            parentName = '';
            childName = '';
            for i = 0:(node.getLength()-1)
                child = node.item(i);
                switch char(child.getNodeName())
                    case 'parent'
                        parentName = char(child.getAttribute('link'));
                    case 'child'
                        childName = char(child.getAttribute('link'));
                end
            end
            obj = urdf.joints.Floating(name, parentName, childName);
        end
    end
end

