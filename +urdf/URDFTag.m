classdef URDFTag < handle
    %URDFTAG URDFTag is the main urdf element xml tag base class
    %   URDFTag base class provides all the XML and common urdf element
    %   properties. All urdf elements are subclasses of this class and
    %   override specific functionality as needed.
    
    properties
        type
        parent
        children
        attributes
        tabs
    end
    
    methods
        function obj = URDFTag(type, name)
            %URDFTAG Construct an instance of this class
            if exist('type', 'var')
                obj.type = type;
            end

            obj.attributes = dictionary;
            if exist('name','var')
                obj.attributes('name') = name;
            end
            obj.tabs = 0;
            obj.children = dictionary;
        end

        function name = getName(obj)
            if isConfigured(obj.attributes) && isKey(obj.attributes, 'name')
                name = obj.attributes('name');
                if isa(name, "java.lang.String")
                    name = string(name);
                end
            else
                [~, randStr] = fileparts(tempname);
                name = strcat(obj.type, '_', randStr);
            end
        end
 
        function addAttribute(obj, name, value)
            obj.attributes(name) = value;
        end

        function addAttributes(obj, attrs)
            for index = 1:numel(attrs)
                obj.addAttribute(attrs(index).name, attrs(index).value);
            end
        end

        function addParent(obj, parent)
            obj.parent = parent;
            obj.tabs = parent.tabs + 1;
            if numEntries(obj.children) > 0
                childKeys = keys(obj.children);
                for index = 1:numel(childKeys)
                    child = obj.children(childKeys(index));
                    child = child{1};
                    child.addParent(obj);
                end
            end
        end

        function addChild(obj, child)
            child.addParent(obj);
            obj.children(child.getName()) = {child};
        end
        
        function outputArg = serialize(obj)
            
            %SERIALIZE serialize the tag into a valid xml tag
            %   Object will be serialized into an inline xml tag with the format:
            %       <type name=<attr1 value> .. attrN=<value>> ... </type>

            % Calculate how many tabs to use for indenting the children.
            tabString = '';
            for tabIndex = 1:obj.tabs
                tabString = sprintf('%s\t', tabString);
            end

            % Create the xml tag and print all the attribute name-value
            % pairs.
            outputArg = sprintf('%s<%s', tabString, obj.type);
            postfix = sprintf('</%s>', obj.type);

            if isConfigured(obj.attributes)
                childKeys = obj.attributes.keys;
                for attr_index = 1:numel(childKeys)
                    outputArg = sprintf('%s %s="%s"', outputArg, childKeys(attr_index), obj.attributes(childKeys(attr_index)));
                end
            end

            if numEntries(obj.children) > 0
                outputArg = sprintf('%s>\n', outputArg);
    
                % Add all child tags before closing the xml tag.
                childKeys = keys(obj.children);
                for index = 1:numel(childKeys)
                    child = obj.children(childKeys(index));
                    child = child{1};
                    outputArg = sprintf('%s%s\n', outputArg, child.serialize());
                end
                
                outputArg = sprintf('%s%s%s', outputArg, tabString, postfix);
            else
                outputArg = sprintf('%s/>', outputArg);
            end
        end
    end
end

