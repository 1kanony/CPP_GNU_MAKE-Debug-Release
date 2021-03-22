# CPP_GNU_MAKE-Debug-Release


## Build
Build mode can be either "debug" or "release"
For example:
    ```$ make -f build.mk BUILDMODE=debug build```

### Note!

You have to build this from same directory where is **build.mk**. 
You can't write:
    ```$ make -f build/build.mk BUILDMODE=debug build```

Because in **build.mk** `$(CURDIR)` is used and if you are not in same directory `$(CURDIR)` would not be where **build.mk** file is.


## How it works?

To track changes of header files we need to create depend files. For example we have file.d and it contains:
	```file.o: file.cpp header_file1.h header_file2.h```

But main problem is **makefile**, if *object* files and *makefile* are not in same directory then *depend* files won't work. I come up with creating soft links of ```gExec.mk```, maybe there is better solution but it works well.

## Makefile structure

build.mk - create links and build directories, call gExec.ln.mk

- Set executable name
  
  ```export TARGET.NAME :=```
  
- Set flags

  ```CXXFLAGS.ADDITION.DEBUG := -O0 -g3```

  ```CXXFLAGS.ADDITION.RELEASE := -O3 -DNDEBUG```

  ```export CXXFLAGS :=```contains common flags of *debug* and *release*, for example:  ```-std=c++11```

  *BUILDMODE=debug* ->   ```CXXFLAGS += CXXFLAGS.ADDITION.DEBUG```

  *BUILDMODE=release* -> ```CXXFLAGS += CXXFLAGS.ADDITION.RELEASE```

- Set path for source (*.cpp) files 

  ```export SOURCES.DIR := $(MAINDIR)/path/to/source/files/directory```

  ```MAINDIR``` is parent directory of build

- Set libraries

  ```export LDLIBS := ```

gExec.mk - creates *.d, *.o and executable file

