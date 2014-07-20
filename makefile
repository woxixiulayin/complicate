.PHONY: all clean

OBJS_DIR = objs
EXE_DIR = exes
DEPS_DIR = deps
DIRS = $(OBJS) $(EXE_DIR) $(DEPS_DIR)

EXE = complicat.exe


SOURCE = $(wildcard *.c)
OBJS = $(SOURCE:.c=.o)
OBJS := $(addprefix $(OBJS_DIR)/,$(OBJS))
EXE := $(addprefix $(EXE_DIR)/,$(EXE))

MKDIR = mkdir
RM = rm
RMFLAG = -fr

CC = gcc

all:$(DIRS) $(EXE) $(DIR)
$(DIRS):
	$(MKDIR) $@

$(EXE):$(OBJS)
	$(CC) -o $@ $^

$(OBJS_DIR)/%.o:%.c
	$(CC) -o $@ -c $^
$(DEPS_DIR)/%.dep:%.c
	@echo "MARK $@ ... "
	@set -e;\
	$(RM) $(RMFLAG) $@.tmp;\
	$(CC) -e -MM $^ > $@.tmp;\
	sed '\(.*\)\.o[:]*,$(DEPS_DIR)/\1.o:,g' < $@.tmp >$@;
	$(RM) $(RMFLAG) $@.tmp

clean: 
	$(RM) $(RMFLAG) $(DIRS)  
