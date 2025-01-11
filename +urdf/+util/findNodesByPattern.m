function nodes = findNodesByPattern(rootNode, pattern, options)
    % FINDNODESBYPATTERN Find all URDF nodes whose names match the specified pattern
    %
    % Usage:
    %   nodes = urdf.util.findNodesByPattern(rootNode, pattern)
    %   nodes = urdf.util.findNodesByPattern(rootNode, pattern, options)
    %
    % Parameters:
    %   rootNode - URDFTag object to start search from
    %   pattern - String containing the search pattern (can include wildcards * and ?)
    %   options - Optional struct with search parameters:
    %            .recursive (logical): Search recursively through children (default: true)
    %            .caseSensitive (logical): Case-sensitive search (default: false)
    %            .regularExpression (logical): Use regular expression pattern (default: false)
    %            .typeFilter (string): Filter by node type (default: '')
    %            .maxDepth (numeric): Maximum depth to search (default: inf)
    %
    % Returns:
    %   nodes - Cell array of matching URDFTag objects
    
    % Input validation
    validateattributes(rootNode, {'urdf.URDFTag'}, {'scalar'}, 'findNodesByPattern', 'rootNode');
    validateattributes(pattern, {'char', 'string'}, {'scalartext'}, 'findNodesByPattern', 'pattern');
    
    % Set default options if not provided
    if nargin < 3
        options = struct();
    end
    validateattributes(options, {'struct'}, {}, 'findNodesByPattern', 'options');
    
    % Default option values
    if ~isfield(options, 'recursive')
        options.recursive = true;
    end
    if ~isfield(options, 'caseSensitive')
        options.caseSensitive = false;
    end
    if ~isfield(options, 'regularExpression')
        options.regularExpression = false;
    end
    if ~isfield(options, 'typeFilter')
        options.typeFilter = '';
    end
    if ~isfield(options, 'maxDepth')
        options.maxDepth = inf;
    end
    
    % Convert pattern to regex if not using regex mode
    if ~options.regularExpression
        % Escape special regex characters
        pattern = regexptranslate('escape', pattern);
        % Convert wildcards to regex patterns
        pattern = strrep(pattern, '\*', '.*');
        pattern = strrep(pattern, '\?', '.');
    end
    
    % Set case sensitivity flag for regex
    if options.caseSensitive
        regexFlags = '';
    else
        regexFlags = 'ignorecase';
    end
    
    % Start recursive search
    nodes = searchNodes(rootNode, pattern, regexFlags, options, 1, {});
end

function nodes = searchNodes(node, pattern, regexFlags, options, depth, nodes)
    % Recursive search function
    
    % Check if current node matches
    if matchesPattern(node, pattern, regexFlags, options)
        nodes{end+1} = node;
    end
    
    % Stop if we've reached max depth or recursion is disabled
    if depth >= options.maxDepth || ~options.recursive
        return;
    end
    
    % Search through children if they exist
    if isConfigured(node.children)
        childKeys = keys(node.children);
        for i = 1:numel(childKeys)
            child = node.children(childKeys{i});
            child = child{1}; % Get the actual child object from cell
            nodes = searchNodes(child, pattern, regexFlags, options, depth + 1, nodes);
        end
    end
end

function matches = matchesPattern(node, pattern, regexFlags, options)
    % Check if node matches search criteria
    
    % Check type filter first if specified
    if ~isempty(options.typeFilter) && ~strcmp(node.type, options.typeFilter)
        matches = false;
        return;
    end
    
    % Get node name
    nodeName = node.getName();
    
    % Check if name matches pattern
    matches = ~isempty(regexp(nodeName, pattern, 'once', regexFlags));
end