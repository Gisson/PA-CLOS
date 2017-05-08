TARGETDIR=target/
SRCDIR=src/
FLAGS=--silent
MAIN_FILENAME=load
TESTDIR=tests/
TESTFILE=tests


all: test

test: $(TARGETDIR)$(MAIN_FILENAME).fas
	clisp $(FLAGS) -i $(TESTDIR)$(TESTFILE).lisp
	

run: $(TARGETDIR)$(MAIN_FILENAME).fas 
	clisp $(FLAGS) -i $(TARGETDIR)$(MAIN_FILENAME).fas

$(TARGETDIR): 
	mkdir $(TARGETDIR)

$(TARGETDIR)$(MAIN_FILENAME).fas: $(SRCDIR)$(MAIN_FILENAME).lisp $(TARGETDIR)
	clisp $(FLAGS) -c $(SRCDIR)$(MAIN_FILENAME).lisp -o $(TARGETDIR)

clean:
	$(RM) -r $(TARGETDIR)
