# MATLAB URDF Builder

A MATLAB toolkit for programmatically creating, modifying, and managing URDF (Unified Robot Description Format) files. This library provides an object-oriented interface for robot model construction and manipulation.

## Features

- **Complete URDF Element Support**
  - Links and Joints (Continuous, Fixed, Floating, Planar, Prismatic, Revolute)
  - Visual and Geometric Components (Box, Cylinder, Sphere, Mesh)
  - Origins and Transformations
  - Materials and Properties

- **Object-Oriented Design**
  - Clean class hierarchy with `URDFTag` as base class
  - Modular component structure
  - Extensible architecture

- **Comprehensive Joint Types**
  - Continuous joints for unlimited rotation
  - Fixed joints for rigid connections
  - Floating joints for unconstrained motion
  - Planar joints for 2D movement
  - Prismatic joints for linear motion
  - Revolute joints with configurable limits

- **Advanced Geometry Support**
  - Basic shapes (Box, Cylinder, Sphere)
  - Mesh import capabilities
  - Visual component management
  - Origin and transformation handling

- **XML Processing**
  - Read existing URDF files
  - Write URDF files
  - Compare URDF structures
  - Validate URDF syntax

## Installation

1. Clone the repository:
```bash
git clone https://github.com/[username]/robotBuilder_matlab.git
```

2. Add the project directory to your MATLAB path:
```matlab
addpath('/path/to/robotBuilder_matlab');
```

## Usage

### Creating a Simple Robot

```matlab
% Initialize a new robot
robot = urdf.Robot('my_robot');

% Add a base link
base_link = urdf.Link('base_link');
robot.addLink(base_link);

% Add a joint
joint = urdf.joints.Revolute('joint1', 'base_link', 'link1', -pi/2, pi/2, 100, 1);
robot.addJoint(joint);

% Write to file
urdf.util.writeToURDFFile(robot, 'my_robot.urdf');
```

### Loading Existing URDF

```matlab
% Read from file
robot_node = urdf.util.readXML('existing_robot.urdf');
robot = urdf.Robot.buildFromURDF(robot_node);
```

## Project Structure

```
robotBuilder_matlab/
├── +urdf/
│   ├── +joints/
│   │   ├── Continuous.m
│   │   ├── Fixed.m
│   │   ├── Floating.m
│   │   ├── Planar.m
│   │   ├── Prismatic.m
│   │   └── Revolute.m
│   ├── +shapes/
│   │   ├── Box.m
│   │   ├── Cylinder.m
│   │   ├── Mesh.m
│   │   └── Sphere.m
│   ├── +util/
│   │   ├── compareURDF.m
│   │   ├── readXML.m
│   │   └── writeToURDFFile.m
│   ├── Axis.m
│   ├── Builder.m
│   ├── Component.m
│   ├── Geometry.m
│   ├── Joint.m
│   ├── Link.m
│   ├── Material.m
│   ├── Origin.m
│   ├── Robot.m
│   ├── URDFTag.m
│   └── Visual.m
```

## Key Classes

- **Robot**: Main container class for the URDF model
- **Link**: Represents physical elements of the robot
- **Joint**: Base class for all joint types
- **URDFTag**: Base class providing XML functionality
- **Geometry**: Handles visual representation
- **Origin**: Manages spatial transformations

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

## Citing

If you use this software in your research, please cite:
```
@software{robotbuilder_matlab,
  title={MATLAB URDF Builder},
  author={[Authors]},
  year={2024},
  url={https://github.com/[username]/robotBuilder_matlab}
}
```
