# makefile for big numbers in Lua

# change this to reflect your installation
LUA=/tmp/lua-4.0
LUALIB= $(LUA)/lib
LUAINC= $(LUA)/include

CC= gcc
CFLAGS= $(INCS) $(DEFS) $(WARN) -O2 -g
WARN= -ansi -pedantic -Wall #-Wmissing-prototypes

INCS= -I$(LUAINC) -I.
LIBS= -L$(LUALIB) -llua -llualib -lm

OBJS= number.o bclib.o main.o

T=a.out

all:	$T

$T:	$(OBJS)
	$(CC) -o $@ $(OBJS) $(LIBS)

clean:
	rm -f $T $(OBJS) core

test:	$T
	$T test.lua

# distribution

D=bc
A=$D.tar.gz
TOTAR=Makefile,README,bclib.c,config.h,main.c,number.c,number.h,test.lua,tm.lua

tar:	clean
	tar zcvf $A -C .. $D/{$(TOTAR)}

distr:	tar
	mv $A ftp

diff:
	tar zxf ftp/$A
	diff . $D
