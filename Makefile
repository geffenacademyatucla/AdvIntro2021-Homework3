default:
	@$(MAKE) -C ./src

#
# Cool code excerpt from
#
# https://pawamoy.github.io/posts/pass-makefile-args-as-typed-in-command-line/
#
# original version prints args as <x=".."> ...
# args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),$a="$($a)"))

# ... I want to pass the naked arguments
args = $(foreach a,$($(subst -,_,$1)_args),$(if $(value $a),"$($a)"))

# make takes arguments of x=... y=... z=...

# this section needs to have corresponding macro name sans _args
# in the Grades macro section
GradeApp_args = x y z

GRADES = \
	GradeApp

#
# the default make target entry
#

#default: classes	
	
.PHONY: $(GRADES) eval
$(GRADES):
	@cd src && java -cp .:lib/hamcrest-2.2.jar GradeApp $(call args,$@)	


# https://www.cs.swarthmore.edu/~newhall/unixhelp/javamakefiles.html
# define compiler and compiler flag variables
#

JFLAGS = -g -cp .:lib/hamcrest-2.2.jar 
JC = javac


#
# Clear any default targets for building .class files from .java files; we 
# will provide our own target entry to do this in this makefile.
# make has a set of default targets for different suffixes (like .c.o) 
# Currently, clearing the default for .java.class is not necessary since 
# make does not have a definition for this target, but later versions of 
# make may, so it doesn't hurt to make sure that we clear any default 
# definitions for these
#

.SUFFIXES: .java .class


#
# Here is our target entry for creating .class files from .java files 
# This is a target entry that uses the suffix rule syntax:
#	DSTS:
#		rule
#  'TS' is the suffix of the target file, 'DS' is the suffix of the dependency 
#  file, and 'rule'  is the rule for building a target	
# '$*' is a built-in macro that gets the basename of the current target 
# Remember that there must be a < tab > before the command line ('rule') 
#

.java.class:
	$(JC) $(JFLAGS) $*.java


#
# CLASSES is a macro consisting of 4 words (one for each java source file)
#

CLASSES = \
	GradeApp.java 




#
# This target entry uses Suffix Replacement within a macro: 
# $(name:string1=string2)
# 	In the words in the macro named 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .java of all words in the macro CLASSES 
# with the .class suffix
#

classes: $(CLASSES:.java=.class)


#
# RM is a predefined macro in make (RM = rm -f)
#

clean:
	$(RM) *.class
	
test: default
	@echo "for grades 85.5 90 78 => Current Grade: B"
	@echo your code outputs: 
	@cd src &&  java -cp .:lib/hamcrest-2.2.jar GradeApp 85.5 90 78 && cd ..
	@echo	
	@echo "for grades 84 79 75.9 => Current Grade: C"
	@echo your code outputs:
	@cd src && java -cp .:lib/hamcrest-2.2.jar GradeApp 84 79 75.9 && cd ..
	@echo
	@echo "for grades 95.2 89.0 91.3 => Current Grade: A"
	@echo your code outputs:
	@cd src && java -cp .:lib/hamcrest-2.2.jar GradeApp 95.2 89.0 91.3 && cd ..
	@echo

	
	

