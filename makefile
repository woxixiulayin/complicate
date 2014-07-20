.PHONY: all clean

OBJS_DIR = objs
EXE_DIR = exes
DEPS_DIR = deps
DIRS = $(OBJS_DIR) $(EXE_DIR) $(DEPS_DIR)

EXE = complicat.exe


SOURCE = $(wildcard *.c)
OBJS = $(SOURCE:.c=.o)
OBJS := $(addprefix $(OBJS_DIR)/,$(OBJS))
DEPS =$(SOURCE:.c=.dep)
DEPS := $(addprefix $(DEPS_DIR)/,$(DEPS))
EXE := $(addprefix $(EXE_DIR)/,$(EXE))

MKDIR = mkdir
RM = rm
RMFLAG = -fr

CC = gcc

all: $(EXE) 

ifeq ("$(wildcard $(DEPS_DIR))", "")
DEPS_DIR_DEPS := $(DEPS_DIR)
endif

ifneq ($(MAKECMDGOALS), clean)
-include $(DEPS)
endif

$(DIRS):
	$(MKDIR) $@

$(EXE):$(EXE_DIR) $(OBJS)
	$(CC) -o $@ $(filter %.o,$^) 
	@echo "目标文件目录$(BJS_DIR)"

$(OBJS_DIR)/%.o:$(OBJS_DIR) %.c
	$(CC) -o $@ -c $(filter %.c,$^)
$(DEPS_DIR)/%.dep:$(DEPS_DIR_DEPS) %.c
	@echo "MARK $@ ... "
	set -e;\
	$(RM) $(RMFLAG) $@.tmp;\
	$(CC) -E -MM $(filter %.c,$^) > $@.tmp;\
	sed 's,\(.*\)\.o[:]*,objs/\1.o: $@,g' < $@.tmp > $@;\
	$(RM) $(RMFLAG) $@.tmp
clean: 
	$(RM) $(RMFLAG) $(DIRS) 
