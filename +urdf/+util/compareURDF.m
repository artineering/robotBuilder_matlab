function differences = compareURDF(file1, file2)
    % Compare two URDF files accounting for different tag ordering
    % Input: file1, file2 - paths to URDF files
    % Output: differences - struct containing differences found
    
    % Read XML files
    try
        xml1 = xmlread(file1);
        xml2 = xmlread(file2);
    catch
        error('Error reading URDF files. Make sure both files exist and are valid XML.');
    end
    
    % Initialize differences struct
    differences.missing_in_file1 = {};
    differences.missing_in_file2 = {};
    differences.attribute_differences = {};
    
    % Get root elements
    root1 = xml1.getDocumentElement();
    root2 = xml2.getDocumentElement();
    
    % Compare complete hierarchies
    differences = compareElements(root1, root2, '', differences);
end

function differences = compareElements(element1, element2, path, differences)
    % Compare two XML elements recursively
    
    % Get all child nodes
    children1 = element1.getChildNodes();
    children2 = element2.getChildNodes();
    
    % Create maps to store elements by their identifying attributes
    elements1 = containers.Map();
    elements2 = containers.Map();
    
    % Process children of first element
    for i = 0:children1.getLength()-1
        child = children1.item(i);
        if child.getNodeType() == child.ELEMENT_NODE
            key = generateElementKey(child);
            if ~isKey(elements1, key)
                elements1(key) = child;
            else
                % Handle duplicate keys by appending index
                j = 1;
                while isKey(elements1, [key '_' num2str(j)])
                    j = j + 1;
                end
                elements1([key '_' num2str(j)]) = child;
            end
        end
    end
    
    % Process children of second element
    for i = 0:children2.getLength()-1
        child = children2.item(i);
        if child.getNodeType() == child.ELEMENT_NODE
            key = generateElementKey(child);
            if ~isKey(elements2, key)
                elements2(key) = child;
            else
                % Handle duplicate keys by appending index
                j = 1;
                while isKey(elements2, [key '_' num2str(j)])
                    j = j + 1;
                end
                elements2([key '_' num2str(j)]) = child;
            end
        end
    end
    
    % Compare elements
    keys1 = elements1.keys();
    keys2 = elements2.keys();
    
    % Find elements missing in file2
    for i = 1:length(keys1)
        key = keys1{i};
        if ~isKey(elements2, key)
            currentPath = [path '/' char(elements1(key).getNodeName())];
            differences.missing_in_file2{end+1} = currentPath;
        end
    end
    
    % Find elements missing in file1
    for i = 1:length(keys2)
        key = keys2{i};
        if ~isKey(elements1, key)
            currentPath = [path '/' char(elements2(key).getNodeName())];
            differences.missing_in_file1{end+1} = currentPath;
        end
    end
    
    % Compare common elements
    commonKeys = intersect(keys1, keys2);
    for i = 1:length(commonKeys)
        key = commonKeys{i};
        elem1 = elements1(key);
        elem2 = elements2(key);
        
        % Compare attributes
        attrs1 = elem1.getAttributes();
        attrs2 = elem2.getAttributes();
        
        if attrs1.getLength() ~= attrs2.getLength()
            currentPath = [path '/' char(elem1.getNodeName())];
            differences.attribute_differences{end+1} = sprintf('%s: Different number of attributes', currentPath);
        else
            for j = 0:attrs1.getLength()-1
                attr1 = attrs1.item(j);
                attr2 = attrs2.getNamedItem(attr1.getName());
                
                if isempty(attr2) || ~strcmp(attr1.getValue(), attr2.getValue())
                    currentPath = [path '/' char(elem1.getNodeName())];
                    differences.attribute_differences{end+1} = sprintf('%s: Attribute "%s" differs', ...
                        currentPath, char(attr1.getName()));
                end
            end
        end
        
        % Recurse into child elements
        differences = compareElements(elem1, elem2, [path '/' char(elem1.getNodeName())], differences);
    end
end

function key = generateElementKey(element)
    % Generate a unique key for an element based on its name and identifying attributes
    
    % Start with element name
    key = char(element.getNodeName());
    
    % Add important attributes that help identify the element
    attrs = element.getAttributes();
    if ~isempty(attrs)
        % Common identifying attributes in URDF
        idAttrs = {'name', 'joint', 'link', 'id'};
        
        for i = 1:length(idAttrs)
            attrNode = attrs.getNamedItem(idAttrs{i});
            if ~isempty(attrNode)
                key = [key '_' char(attrNode.getValue())];
                break;  % Use first matching identifier found
            end
        end
    end
end