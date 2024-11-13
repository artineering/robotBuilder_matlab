classdef Revolute < urdf.Joint
    % urdf.joints.Revolute class implements the revolute joint which has
    % properties such as lower, upper, effort and velocity.
    
    methods
        function obj = Revolute(name, parentLink, childLink, lower, upper, effort, velocity)
            obj@urdf.Joint(name, 'revolute', parentLink, childLink);

            limit = urdf.URDFTag('limit');
            limit.addAttribute('lower', num2str(lower));
            limit.addAttribute('upper', num2str(upper));
            limit.addAttribute('effort', num2str(effort));
            limit.addAttribute('velocity', num2str(velocity));

            obj.addChild(limit);
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            name = char(node.getAttribute('name'));
            parentName = '';
            childName = '';
            lower = '';
            upper = '';
            effort = '';
            velocity = '';
            for i = 0:(node.getLength()-1)
                child = node.item(i);
                switch char(child.getNodeName())
                    case 'parent'
                        parentName = char(child.getAttribute('link'));
                    case 'child'
                        childName = char(child.getAttribute('link'));
                    case 'limit'
                        lower = str2double(child.getAttribute('lower'));
                        upper = str2double(child.getAttribute('upper'));
                        effort = str2double(child.getAttribute('effort'));
                        velocity = str2double(child.getAttribute('velocity'));
                end
            end
            obj = urdf.joints.Revolute(name, parentName, childName, lower, upper, effort, velocity);
        end
    end
end

