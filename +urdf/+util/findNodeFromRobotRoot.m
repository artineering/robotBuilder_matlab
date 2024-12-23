function node = findNodeFromRobotRoot(model, path)
    node = urdf.URDFTag;
    levels = strsplit(path, '.');
    currentNode = model;

    % If the path only contains the root-level node of the model, simply
    % return the model.
    if isequal(length(levels), 1) && strcmp(currentNode.getName(), levels{1})
        node = currentNode;
        return
    end

    rootLevel = currentNode.getName();
    % Root level should match the model name.
    if ~strcmp(rootLevel, levels{1})
        return
    end

    % If the model is a Robot instance, serialize it once to populate its
    % children.
    if isa(model, "urdf.Robot")
        model.serialize();
    end

    % Check if the model has children
    if ~isConfigured(currentNode.children)
        % If the model has no children, then check if the second level is
        % an attribute. If yes, they return the currentNode as the found
        % node.
        attribute = currentNode.attributes.lookup(levels{2}, "FallbackValue", '');
        if ~isempty(attribute)
            node = currentNode;
        end
        return
    end

    % If the path contains more levels, traverse the levels and check if
    % the model contains children that match the level name.
    for index = 2:length(levels)
        level = levels{index};
        if ~isConfigured(currentNode.children)
            attribute = currentNode.attributes.lookup(level, "FallbackValue", '');
            if ~isempty(attribute)
                node = currentNode;
            end
            return
        else
            childNode = currentNode.children.lookup(level, "FallbackValue", {urdf.URDFTag});
            if isa(childNode, "cell")
                childNode = childNode{1};
            end
            if urdf.util.isNullTag(childNode)
                % if the child node returned as NULL, check if the level
                % actually is a type and not a name.
                childNode = currentNode.findChild(level);
                if isa(childNode, "cell")
                    childNode = childNode{1};
                end
    
                % If we did not find the level with the type information as
                % well, perhaps its an attribute.
                if urdf.util.isNullTag(childNode)
                    attribute = currentNode.attributes.lookup(level, "FallbackValue", '');
                    if isempty(attribute)
                        return
                    else
                        % Make sure that the attribute is always the last level
                        % in the path. If its not, then the path is badly
                        % formed and we should return nothing.
                        if ~isequal(index, length(levels))
                            return
                        end
    
                        % We have indeed reached an attribute which is the last
                        % level on the path. We can safely return the current
                        % node as the desired node.
                        node = currentNode;
                    end
                end
            end
            currentNode = childNode;
        end
    end
    node = currentNode;
end

