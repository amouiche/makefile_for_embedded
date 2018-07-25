This project is an attempt to show different ways to write Makefiles for building/managing "bare metal" projects (and to give some ideas to write your own).

For some reasons, people usually think this is a complicated task and they prefer using a IDE (Keil, IAR ...). May be the "You just need to press the build button to build the example provided in the SDK" feature is a good reason to try those IDEs. Yet, as soon as you start building you own project and linking multiple sub-modules or wanting to improve factorization among different projects, IDEs are complicated and don't make  you task easy at all...(I also have plenty other reasons do not like them, but this is not the subject here.)

You will find 4 Makefile framework. They don't differs a lot from each other and simply emphasis some features, and give you the choice between "something very very simple" to "a framework of 10+ libs for building multiple different projects (platforms, features...) sharing those libs with highest code factorization level".

In each example, we are linking 3 libraries as if they were imported from 3rd parties or external repositories.
There is a C, C++ and Assembly in order to show that mixing such libs is not an issue.

Building is done with arm-none-eabi-gcc toolchain which is very handy to have available on various sytems.
For example, on debian based Linux (Ubuntu, ...), juste run:
`sudo apt install gcc-arm-none-eabi`.

The result of the build is a ARM ELF file, directly executable with QEMU. Simply execute `make test`to build and run the result with qemu. (On debian 
`sudo apt install qemu-system-arm`)


# Projects


## 1 - Basic

Pros:

* Very easy to understand

Cons:

* Difficult to maintained when the project grows
* Nothing is factorized if you have 2 or more projects



## 2 - Modularized

So the main issue with (1) is modularization. If 2 projects are using the same lib, and for example, you add a source file to the lib, then every makefile must be modified... :(
The solution is to have a module description file (called Module.mk in our example). The top makefile will source those Module.mk files to know the details to build one lib.

Pros:

* Group of code by modules, each module makefile describing the files to build
* Top makefile is very simple


Limitations:

* Since objects are built in the same directory than source file, 2 differents projects with common modules can't be built at the same time, or a project can't be build at the same time with differents options.
* 'make clean' is not so easy to perform since objects files are built in the same directory as the source.



## 3 - Separate build directory

Pros:

* Fix the limitation to build 2 projects without a complete 'make clean' between each build.
Cons:
* VPATH usage can make difficult to find the proper source file if different source file with same name appears in the project

Limitations:

* 2 functions with same name can't appear in different modules (also an issue for (1) and (2))


## 4 - Intermediate Module library

Pros:

* Modules are built and grouped into an intermediate library
* Specific CFLAGS & co can 't be applied for a particular group with interfering with the whole project
* Source files with identical name belonging in different modules is not a problem


Cons:

* More complex


# Building and testing

```
cd [project]
make help  # description of parameters to call make

make all   # build

make test  # running with qemu
```