TARGETDIR=target/
SRCDIR=src/
FLAGS=--silent
MAIN_FILENAME=load
TESTDIR=tests/
TESTFILE=tests


all: test

test: 
	@echo -e "\033[31m"
	clisp $(FLAGS) < $(TESTDIR)$(TESTFILE).lisp
	@echo -e "\e[0m"
	

run: $(TARGETDIR)$(MAIN_FILENAME).fas 
	clisp $(FLAGS) -i $(TARGETDIR)$(MAIN_FILENAME).fas

$(TARGETDIR): 
	mkdir $(TARGETDIR)

$(TARGETDIR)$(MAIN_FILENAME).fas: $(SRCDIR)$(MAIN_FILENAME).lisp $(TARGETDIR)
	clisp $(FLAGS) -c $(SRCDIR)$(MAIN_FILENAME).lisp -o $(TARGETDIR)

clean:
	$(RM) -r $(TARGETDIR)
