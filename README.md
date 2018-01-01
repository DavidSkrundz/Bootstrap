Bootstrap [![Swift Version](https://img.shields.io/badge/Swift-4.0-orange.svg)](https://swift.org/download/#releases) [![Platforms](https://img.shields.io/badge/Platforms-macOS%20|%20Linux-lightgray.svg)](https://swift.org/download/#releases) [![Build Status](https://travis-ci.org/DavidSkrundz/Bootstrap.svg?branch=master)](https://travis-ci.org/DavidSkrundz/Bootstrap) [![Codebeat Status](https://codebeat.co/badges/a40d28c1-5a82-40b2-b34e-ab416e06fcad)](https://codebeat.co/projects/github-com-davidskrundz-bootstrap) [![Codecov](https://codecov.io/gh/DavidSkrundz/Bootstrap/branch/master/graph/badge.svg)](https://codecov.io/gh/DavidSkrundz/Bootstrap)
=========

Bootstrap Swift scripting using modules

## Installation

Installation does not create any files or directories outside of `Bootstrap/`, `Modules/`, and `.ModuleMaps/`

Note: Do not run `install` if you want to save changes you've made to the repo

```
git clone https://github.com/DavidSkrundz/Bootstrap.git
cd Bootstrap
./install
```

## Getting Packages

```
cd ../Modules
git clone <repo>
```

## Building Packages

```
cd ../Bootstrap
./build --all
  or
./build <module>
```

or

```
Bootstrap --build <--all | module>
```

## Directory Structure

```
┬─<root>/
├─┬─Bootstrap/
│ ├─Bootstrap
│ ├─build
│ ├─install
│ ├─.../
├─┬─Modules/
│ ├─Module1
│ ├─Module2
├─┬─.ModuleMaps/
│ ├─Module1.modulemap
│ ├─Module2.modulemap
```
