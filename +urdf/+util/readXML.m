function robotNode = readXML(filename)
    try
        node = xmlread(filename);
        robotNode = node.getDocumentElement();
    catch
        error('Failed to read XML file %s.', filename);
    end
end

