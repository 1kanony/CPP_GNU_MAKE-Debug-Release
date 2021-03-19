DEPENDFLAGS = -MM -MMD -MF $(patsubst $(SOURCES.DIR)/%.cpp, $(DEPENDSDIR.PATH)/%.d, $^)

all: $(TARGET.NAME)

$(TARGET.NAME): $(OBJECTS.NAME)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDLIBS)

%.o: $(SOURCES.DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -c $<

$(DEPENDSDIR.PATH)/%.d: $(SOURCES.DIR)/%.cpp
	$(CXX) $< $(DEPENDFLAGS)

clean:
	-$(RM) $(OBJECTS.NAME) ../$(DEPENDSDIR.NAME)/*

include $(DEPENDS.PATH)
