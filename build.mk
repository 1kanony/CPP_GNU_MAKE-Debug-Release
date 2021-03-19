EXECLN = $(MAINDIR)/build/$(BUILDDIR.NAME)/gExec.ln.mk

MAINDIR := $(CURDIR)/..

export CXX := g++
export TARGET.NAME := 

# export RM := gio trash
 
BUILDDIR.NAME = 
BUILDDIR.NAME.DEBUG := debug
BUILDDIR.NAME.RELEASE := release

export DEPENDSDIR.NAME := depends
export DEPENDSDIR.PATH = $(MAINDIR)/build/$(DEPENDSDIR.NAME)
 
CXXFLAGS.ADDITION.DEBUG := -O0 -g3
CXXFLAGS.ADDITION.RELEASE := -O3 -DNDEBUG
export CXXFLAGS := 
 
export CPPFLAGS := -D PATH=\"$(shell pwd)/../\"
export LDLIBS   := 
 
export SOURCES.DIR := $(MAINDIR)/path/to/source/folder/
export SOURCES.NAME := $(wildcard $(SOURCES.DIR)/*.cpp)
export DEPENDS.NAME := $(patsubst $(SOURCES.DIR)/%.cpp, %.d, $(SOURCES.NAME))
export OBJECTS.NAME := $(patsubst $(SOURCES.DIR)/%.cpp, %.o, $(SOURCES.NAME))
 
export DEPENDS.PATH = $(addprefix $(DEPENDSDIR.PATH)/, $(DEPENDS.NAME))
 
ifeq ($(BUILDMODE), debug)
BUILDDIR.NAME = $(BUILDDIR.NAME.DEBUG)
CXXFLAGS += $(CXXFLAGS.ADDITION.DEBUG)
else ifeq ($(BUILDMODE), release)
BUILDDIR.NAME = $(BUILDDIR.NAME.RELEASE)
CXXFLAGS += $(CXXFLAGS.ADDITION.RELEASE)
else
$(error BUILD was not defined correctly)
endif


build: | $(BUILDDIR.NAME) $(EXECLN) $(DEPENDSDIR.NAME)
	$(MAKE) -C $(BUILDDIR.NAME) -f $(EXECLN) all

delete:
	# ...

clean:
	$(MAKE) -C $(BUILDDIR.NAME) -f $(EXECLN) clean

$(DEPENDSDIR.NAME):
	mkdir -p $@

$(BUILDDIR.NAME):
	mkdir -p $@

$(EXECLN):
	ln -s $(MAINDIR)/gExec.mk $@

remove:
	-$(RM) $(BUILDDIR.NAME) $(DEPENDSDIR.NAME)
