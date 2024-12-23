<div align="left" style="position: relative;">
<h1>MATLAB URDF Builder</h1>
<p align="left">
	A MATLAB toolkit for programmatically creating, modifying, and managing URDF (Unified Robot Description Format) files. This library provides an object-oriented interface for robot model construction and manipulation.
</p>
<p align="left">
	<img src="https://img.shields.io/github/license/artineering/robotBuilder_matlab?style=default&logo=opensourceinitiative&logoColor=white&color=0080ff" alt="license">
	<img src="https://img.shields.io/github/last-commit/artineering/robotBuilder_matlab?style=default&logo=git&logoColor=white&color=0080ff" alt="last-commit">
	<img src="https://img.shields.io/github/languages/top/artineering/robotBuilder_matlab?style=default&color=0080ff" alt="repo-top-language">
	<img src="https://img.shields.io/github/languages/count/artineering/robotBuilder_matlab?style=default&color=0080ff" alt="repo-language-count">
</p>
<p align="left"><!-- default option, no dependency badges. -->
</p>
<p align="left">
	<!-- default option, no dependency badges. -->
</p>
</div>
<br clear="right">

##  Table of Contents

- [ Overview](#-overview)
- [ Project Structure](#-project-structure)
- [ Getting Started](#-getting-started)
  - [ Prerequisites](#-prerequisites)
  - [ Installation](#-installation)
  - [ Usage](#-usage)
- [ Contributing](#-contributing)
- [ License](#-license)

---

##  Overview

- **Complete URDF Element Support**
  - Links and Joints (Continuous, Fixed, Floating, Planar, Prismatic, Revolute)
  - Visual and Geometric Components (Box, Cylinder, Sphere, Mesh)
  - Origins and Transformations
  - Materials and Properties
  - Reusable Component assemblies

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

- **Comprehensive Geometry Support**
  - Basic shapes (Box, Cylinder, Sphere)
  - Mesh import capabilities
  - Visual component management
  - Origin and transformation handling

- **Reusable Component Assembly Support**
  - Create reusable component assemblies with links and joints
  - Define and attach parameters to component assemblies
  - Create unique component instances with their own set of parameter values

- **XML Processing**
  - Read existing URDF files
  - Write URDF files
  - Compare URDF structures
  - Validate URDF syntax

---

##  Project Structure

```sh
└── robotBuilder_matlab/
    ├── +urdf
    │   ├── +joints
    │   │   ├── Continuous.m
    │   │   ├── Fixed.m
    │   │   ├── Floating.m
    │   │   ├── Planar.m
    │   │   ├── Prismatic.m
    │   │   └── Revolute.m
    │   ├── +shapes
    │   │   ├── Box.m
    │   │   ├── Cylinder.m
    │   │   ├── Mesh.m
    │   │   └── Sphere.m
    │   ├── +util
    │   │   ├── isNullTag.m
    │   │   ├── findNodeFromRobotRoot.m
    │   │   ├── compareURDF.m
    │   │   ├── readXML.m
    │   │   └── writeToURDFFile.m
    │   ├── Axis.m
    │   ├── Builder.m
    │   ├── Component.m
    │   ├── Geometry.m
    │   ├── Inertial.m
    │   ├── Joint.m
    │   ├── Link.m
    │   ├── Material.m
    │   ├── Origin.m
    │   ├── Robot.m
    │   ├── URDFTag.m
    │   └── Visual.m
    ├── LICENSE
    └── minion.mlx
```

## Key Classes

- **Robot**: Main container class for the URDF model
- **Component**: Reusable component class for component assemblies
- **Link**: Represents physical elements of the robot
- **Joint**: Base class for all joint types
- **URDFTag**: Base class providing XML functionality
- **Geometry**: Handles visual representation
- **Origin**: Manages spatial transformations

---
##  Getting Started

###  Prerequisites

Before getting started with robotBuilder_matlab, ensure your runtime environment meets the following requirements:

- **Programming Language:** MATLAB
- **Tools:** MATLAB (Version R2023b and Above)


###  Installation

1. Clone the repository:
```bash
git clone https://github.com/artineering/robotBuilder_matlab.git
```

2. Add the project directory to your MATLAB path:
```matlab
addpath('/path/to/robotBuilder_matlab');
```



###  Usage
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

---

##  Contributing

- **💬 [Join the Discussions](https://github.com/artineering/robotBuilder_matlab/discussions)**: Share your insights, provide feedback, or ask questions.
- **🐛 [Report Issues](https://github.com/artineering/robotBuilder_matlab/issues)**: Submit bugs found or log feature requests for the `robotBuilder_matlab` project.
- **💡 [Submit Pull Requests](https://github.com/artineering/robotBuilder_matlab/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/artineering/robotBuilder_matlab
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="left">
   <a href="https://github.com{/artineering/robotBuilder_matlab/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=artineering/robotBuilder_matlab">
   </a>
</p>
</details>

---

##  License

This project is licensed under the Apache 2.0 License - see the LICENSE file for details.

---

## Citing

If you use this software in your research, please cite:
```
@software{robotbuilder_matlab,
  title={MATLAB URDF Builder},
  author={Siddharth Vaghela},
  year={2024},
  url={https://github.com/artineering/robotBuilder_matlab}
}
```
