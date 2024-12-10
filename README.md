<div align="left" style="position: relative;">
<h1>ROBOTBUILDER_MATLAB</h1>
<p align="left">
	MATLAB tool for building Robot URDF files.
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
- [ Features](#-features)
- [ Project Structure](#-project-structure)
  - [ Project Index](#-project-index)
- [ Getting Started](#-getting-started)
  - [ Prerequisites](#-prerequisites)
  - [ Installation](#-installation)
  - [ Usage](#-usage)
  - [ Testing](#-testing)
- [ Project Roadmap](#-project-roadmap)
- [ Contributing](#-contributing)
- [ License](#-license)
- [ Acknowledgments](#-acknowledgments)

---

##  Overview

<code>❯ REPLACE-ME</code>

---

##  Features

<code>❯ REPLACE-ME</code>

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


###  Project Index
<details open>
	<summary><b><code>ROBOTBUILDER_MATLAB/</code></b></summary>
	<details> <!-- __root__ Submodule -->
		<summary><b>__root__</b></summary>
		<blockquote>
			<table>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/minion.mlx'>minion.mlx</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/RobotBuilder_matlab.prj'>RobotBuilder_matlab.prj</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			</table>
		</blockquote>
	</details>
	<details> <!-- +urdf Submodule -->
		<summary><b>+urdf</b></summary>
		<blockquote>
			<table>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Robot.m'>Robot.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Inertial.m'>Inertial.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Link.m'>Link.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/URDFTag.m'>URDFTag.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Origin.m'>Origin.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Visual.m'>Visual.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Geometry.m'>Geometry.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Axis.m'>Axis.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Builder.m'>Builder.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Component.m'>Component.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Material.m'>Material.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			<tr>
				<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/Joint.m'>Joint.m</a></b></td>
				<td><code>❯ REPLACE-ME</code></td>
			</tr>
			</table>
			<details>
				<summary><b>+util</b></summary>
				<blockquote>
					<table>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+util/writeToURDFFile.m'>writeToURDFFile.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+util/readXML.m'>readXML.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+util/compareURDF.m'>compareURDF.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					</table>
				</blockquote>
			</details>
			<details>
				<summary><b>+shapes</b></summary>
				<blockquote>
					<table>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+shapes/Box.m'>Box.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+shapes/Mesh.m'>Mesh.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+shapes/Sphere.m'>Sphere.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+shapes/Cylinder.m'>Cylinder.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					</table>
				</blockquote>
			</details>
			<details>
				<summary><b>+joints</b></summary>
				<blockquote>
					<table>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+joints/Continuous.m'>Continuous.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+joints/Revolute.m'>Revolute.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+joints/Prismatic.m'>Prismatic.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+joints/Planar.m'>Planar.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+joints/Fixed.m'>Fixed.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					<tr>
						<td><b><a href='https://github.com/artineering/robotBuilder_matlab/blob/master/+urdf/+joints/Floating.m'>Floating.m</a></b></td>
						<td><code>❯ REPLACE-ME</code></td>
					</tr>
					</table>
				</blockquote>
			</details>
		</blockquote>
	</details>
</details>

---
##  Getting Started

###  Prerequisites

Before getting started with robotBuilder_matlab, ensure your runtime environment meets the following requirements:

- **Programming Language:** ObjectiveC


###  Installation

Install robotBuilder_matlab using one of the following methods:

**Build from source:**

1. Clone the robotBuilder_matlab repository:
```sh
❯ git clone https://github.com/artineering/robotBuilder_matlab
```

2. Navigate to the project directory:
```sh
❯ cd robotBuilder_matlab
```

3. Install the project dependencies:

echo 'INSERT-INSTALL-COMMAND-HERE'



###  Usage
Run robotBuilder_matlab using the following command:
echo 'INSERT-RUN-COMMAND-HERE'

###  Testing
Run the test suite using the following command:
echo 'INSERT-TEST-COMMAND-HERE'

---
##  Project Roadmap

- [X] **`Task 1`**: <strike>Implement feature one.</strike>
- [ ] **`Task 2`**: Implement feature two.
- [ ] **`Task 3`**: Implement feature three.

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

This project is protected under the [SELECT-A-LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

##  Acknowledgments

- List any resources, contributors, inspiration, etc. here.

---
