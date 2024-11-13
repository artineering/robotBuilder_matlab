classdef Origin < urdf.URDFTag
    %ORIGIN This class specifies the origin for a link node

    properties
        pitch
        yaw
        roll
        x
        y
        z
    end
    
    methods
        function obj = Origin(roll, pitch, yaw, x, y, z)
            obj@urdf.URDFTag('origin');
            obj.pitch = '0';
            obj.yaw = '0';
            obj.roll = '0';
            obj.x = '0';
            obj.y = '0';
            obj.z = '0';
            if exist("roll", "var") ...
                && exist("pitch", "var") ...
                && exist("yaw", "var") ...
                && exist("x", "var") ...
                && exist("y", "var") ...
                && exist("z", "var")
                obj.reset(roll, pitch, yaw, x, y, z);
            end
        end

        function reset(obj, roll, pitch, yaw, x, y, z)
            obj.setPitch(pitch);
            obj.setYaw(yaw);
            obj.setRoll(roll);
            obj.setX(x);
            obj.setY(y);
            obj.setZ(z);
        end

        function setPitch(obj, pitch)
            if isnumeric(pitch)
                pitch = num2str(pitch);
            end
            obj.pitch = pitch;
        end

        function setYaw(obj, yaw)
            
            if isnumeric(yaw)
                yaw = num2str(yaw);
            end
            obj.yaw = yaw;
        end

        function setRoll(obj, roll)
            
            if isnumeric(roll)
                roll = num2str(roll);
            end
            obj.roll = roll;
        end

        function setX(obj, x)
            
            if isnumeric(x)
                x = num2str(x);
            end
            obj.x = x;
        end

        function setY(obj, y)
            
            if isnumeric(y)
                y = num2str(y);
            end
            obj.y = y;
        end

        function setZ(obj, z)
            
            if isnumeric(z)
                z = num2str(z);
            end
            obj.z = z;
        end

        function outputArg = serialize(obj)
            obj.addAttribute('rpy', sprintf('%s %s %s', obj.roll, obj.pitch, obj.yaw));
            obj.addAttribute('xyz', sprintf('%s %s %s', obj.x, obj.y, obj.z));
            outputArg = serialize@urdf.URDFTag(obj);
        end
    end

    methods(Static)
        function obj = buildFromURDF(node)
            rpy = node.getAttribute('rpy');
            xyz = node.getAttribute('xyz');
            rpy_s = rpy.split(' ');
            xyz_s = xyz.split(' ');
            obj = urdf.Origin(...
                str2double(rpy_s(1)),...
                str2double(rpy_s(2)),...
                str2double(rpy_s(3)),...
                str2double(xyz_s(1)),...
                str2double(xyz_s(2)),...
                str2double(xyz_s(3)));
        end
    end
end

