TARGET		= arrow
INCLUDES	:= -Iinclude -Icompiler
CFLAGS		+= -O2 -Wall -fno-strict-aliasing $(INCLUDES)
LEX 		= flex
LFLAGS 		= -Cf
YACC 		= bison
YFLAGS 		= -d

FLEXFILES = $(wildcard **/*.l)
BISONFILES = $(wildcard **/*.y)
CFLEX = $(patsubst %.l, %.l.c, $(FLEXFILES)) 
CBISON = $(patsubst %.y, %.y.c, $(BISONFILES))
CFILES = $(wildcard source/*.c)
OBJECTS = $(patsubst %.c, %.o, $(CFILES) $(CFLEX) $(CBISON))

%.o: %.c
	@echo "[CC]  $(notdir $<)"
	@$(CC) $(CFLAGS) -c $< -o $(TARGET)

all:
	$(MAKE) grammar
	$(MAKE) lex
	$(MAKE) $(OBJECTS)

grammar:
	@echo "[YACC] $(notdir $<)"
	@$(YACC) --defines="compiler/arrow.y.h" --output="compiler/arrow.y.c" $(YFLAGS) $(BISONFILES)

lex:
	@echo "[LEX]  $(notdir $<)"
	@$(LEX) --header-file="compiler/arrow.l.h" --outfile="compiler/arrow.l.c" $(LFLAGS) $(FLEXFILES)

clean:
	rm -rf $(OBJECTS) $(TARGET) $(CFLEX) $(CBISON) "compiler/arrow.y.h" "compiler/arrow.l.h"
