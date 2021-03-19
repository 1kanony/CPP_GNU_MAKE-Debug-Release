# CPP_GNU_MAKE-Debug-Release


## Build
Build mode can be either "debug" or "release"
For example:

```$ make -f build.mk BUILDMODE=debug build```

## How it works?

To track changes of header files we need to create depend files. For example:
file.d:
	```file.o: file.cpp header_file1.h header_file2.h```

But main problem is **makefile**, if *object* files and *makefile* are not in same directory then *depend* files won't work. I come up with creating soft links of ```gExec.mk```, maybe there is better solution but it works well.

## Makefile structure

build.mk - create links and build directories, call gExec.ln.mk

- Set executable name
  6.```export TARGET.NAME := your_executable_name```

- Set flags

  17. ```CXXFLAGS.ADDITION.DEBUG := -O0 -g3```
  
  18. ```CXXFLAGS.ADDITION.RELEASE := -O3 -DNDEBUG```
  
  19. ```export CXXFLAGS :=``` for example:  ```-std=c++11```
  

  *BUILDMODE=debug* ->   ```CXXFLAGS += CXXFLAGS.ADDITION.DEBUG```
  *BUILDMODE=release* -> ```CXXFLAGS += CXXFLAGS.ADDITION.RELEASE```

- Set path for source (*.cpp) files 

  24. ```export SOURCES.DIR := $(MAINDIR)/path/to/source/files/directory/```

  ```MAINDIR``` is parent directory of build

- Set libraries

  22. ```export LDLIBS := ```

gExec.mk - creates *.d, *.o and executable file