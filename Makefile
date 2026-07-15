# Game Boy project template (RGBDS)

PROJECT := sample
TITLE   := SAMPLE

BUILD_DIR := build
SRCS      := $(wildcard *.rgbasm)
OBJS      := $(SRCS:%.rgbasm=$(BUILD_DIR)/%.o)
DEPS      := $(OBJS:.o=.d)

ROM := $(BUILD_DIR)/$(PROJECT).gb
MAP := $(BUILD_DIR)/$(PROJECT).map
SYM := $(BUILD_DIR)/$(PROJECT).sym

ASM      := rgbasm
LINK     := rgblink
FIX      := rgbfix
EMULATOR := bgb-desktop

ASMFLAGS  := -Werror -Weverything
LINKFLAGS := --tiny --dmg --map $(MAP) --sym $(SYM)
FIXFLAGS  := --title $(TITLE) --pad-value 0 --validate

.PHONY: all run clean

all: $(ROM)

$(ROM): $(OBJS) | $(BUILD_DIR)
	$(LINK) $(LINKFLAGS) -o $@ $^
	$(FIX) $(FIXFLAGS) $@

# -M writes a dependency file so edits to included .rgbinc files trigger a rebuild.
$(BUILD_DIR)/%.o: %.rgbasm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) -M $(@:.o=.d) -MQ $@ -o $@ $<

$(BUILD_DIR):
	mkdir -p $@

run: $(ROM)
	$(EMULATOR) $(abspath $(ROM))

clean:
	rm -rf $(BUILD_DIR)

-include $(DEPS)
