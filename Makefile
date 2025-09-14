hello.txt:
	echo "hello world!" > hello.txt

PICO_TOOLCHAIN_PATH?=~/.pico-sdk/toolchain/14_2_Rel1
CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

LD=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-ld
SRC=main.c second.c
OBJS=$(patsubst %.c,%.o,$(SRC))
FILE=$(patsubst %.c,%.i,$(SRC))

all: firmware.elf

firmware.elf: $(OBJS) 
	$(LD) -o $@ $^

%.s: %.i
	$(CC) -S $@

%.o: %.s
	$(AS) $< -o $@

%.i: %.c
	$(CPP) $< -o $@

clean:
	rm -f $(OBJS) $(patsubst %.c,%.i,$(SRC)) $(patsubst %.c,%.s,$(SRC)) firmware.elf 

.PHONY: clean all