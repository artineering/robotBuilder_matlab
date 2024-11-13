function writeToURDFFile(robot, filename)
    file = fopen(filename, 'w+');
    fprintf(file, '%s', robot.serialize());
    fclose(file);
end

