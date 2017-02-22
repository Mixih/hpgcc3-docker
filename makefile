################################################################################
# basen on an autogenerated makefile
# TODO convert to automake, not jinja
################################################################################

-include ../makefile.init

RM := rm -rf

# All of the sources participating in the build are defined here
-include sources.mk
-include objects.mk
-include subdir.mk

ifneq ($(MAKECMDGOALS),clean)
ifneq ($(strip $(C_DEPS)),)
-include $(C_DEPS)
endif
endif


# Add inputs and outputs from these tool invocations to the build variables
PARTIAL_LINK_EXE += \
USER_OBJS.o \

ELF_EXECUTABLES += \
USER_OBJS.elf \



# standard "all" target
all: out.ex3


# Linker and tool invocations
out.ex3: $(ELF_EXECUTABLES)
	@echo 'Building target: $@'
	@echo 'Invoking: Elf2ARMC'
	elf2armc  $(ELF_EXECUTABLES) "hello.ex3"
	@echo 'Finished building target: $@'
	@echo ' '

USER_OBJS.o: $(OBJS) $(USER_OBJS)
	@echo 'Invoking: C Linker'
	arm-none-eabi-ld $(OBJS) $(USER_OBJS) $(LIBS) -T"/hpgcc3/lib/romentries.list" -i /hpgcc3/lib/RLloader.o -L/hpgcc3/lib -o "USER_OBJS.o"
	@echo 'Finished building: $@'
	@echo ' '

USER_OBJS.elf: $(PARTIAL_LINK_EXE) $(USER_OBJS)
	@echo 'Invoking: C Linker (2nd stage)'
	arm-none-eabi-ld $(PARTIAL_LINK_EXE) $(USER_OBJS) $(LIBS) -T"/hpgcc3/lib/RLld.script" -nodefaultlibs -nostdlib -L/hpgcc3/lib -larmggl -larmhplib -larmhpg -larmhplib -larmfsystem -larmhplib -larmdecnumber -larmhplib -larmgcc -o "USER_OBJS.elf"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(ELF_EXECUTABLES)$(EXECUTABLES)$(OBJS)$(PARTIAL_LINK_EXE)$(C_DEPS) out.ex3
	-@echo ' '

.PHONY: all clean dependents
