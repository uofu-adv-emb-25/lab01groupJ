hello.txt:
	echo "hello world!" > hello.txt

PICO_TOOLCHAIN_PATH?=~/.pico-sdk/toolchain/14_2_Rel1
CPP=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-cpp
CC=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-gcc
AS=$(PICO_TOOLCHAIN_PATH)/bin/arm-none-eabi-as

%.s: %.i
	$(CC) -S $@

%.o: %.s
	$(AS) $< -o $@

%.i: %.c
	$(CPP) $< > $@

clean:
	rm -f main.i hello.txt

.PHONY: clean