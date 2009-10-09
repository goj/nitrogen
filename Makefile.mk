# Define $(,) to be equal to a comma
, := ,

# Define $( ) to be equal to a space
space :=
space +=
$(space) := 
$(space) +=

# The list of compiled modules converted into a comma separated value list
MODULES      = $(patsubst ./ebin/%.beam,%,$(wildcard ./ebin/*.beam))
MODULES_LIST = $(subst $( ),$(,)$( ),$(MODULES))
