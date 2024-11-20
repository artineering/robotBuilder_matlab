function writeToURDFFile(robot, filename)
    file = fopen(filename, 'w+');
    fprintf(file, '<?xml version="1.0" ?>\n%s', robot.serialize());
    fclose(file);
end

