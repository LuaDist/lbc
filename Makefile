# makefile for bc library for Lua

# change these to reflect your Lua installation
LUA= /tmp/lhf/lua-5.1.4
LUAINC= $(LUA)/src
LUALIB= $(LUA)/src
LUABIN= $(LUA)/src

# these will probably work if Lua has been installed globally
#LUA= /usr/local
#LUAINC= $(LUA)/include
#LUALIB= $(LUA)/lib
#LUABIN= $(LUA)/bin

# probably no need to change anything below here
CC= gcc
CFLAGS= $(INCS) $(WARN) -O2 $G
WARN= -ansi -pedantic -Wall
INCS= -I$(LUAINC) -I.
MAKESO= $(CC) -shared
#MAKESO= env MACOSX_DEPLOYMENT_TARGET=10.3 $(CC) -bundle -undefined dynamic_lookup

MYNAME= bc
MYLIB= l$(MYNAME)
T= $(MYNAME).so
OBJS= $(MYLIB).o number.o
TEST= test.lua

all:	test

test:	$T
	$(LUABIN)/lua $(TEST)

o:	$(MYLIB).o

so:	$T

$T:	$(OBJS)
	$(MAKESO) -o $@ $(OBJS)

clean:
	rm -f $(OBJS) $T core core.*

doc:
	@echo "$(MYNAME) library:"
	@fgrep '/**' $(MYLIB).c | cut -f2 -d/ | tr -d '*' | sort | column

# distribution

FTP= www:www/ftp/lua/5.1
F= http://www.tecgraf.puc-rio.br/~lhf/ftp/lua/5.1/$A
D= $(MYNAME)
A= $(MYLIB).tar.gz
TOTAR= Makefile,README,$(MYLIB).c,test.lua,config.h,number.c,number.h

distr:	clean
	tar zcvf $A -C .. $D/{$(TOTAR)}
	touch -r $A .stamp
	scp -p $A $(FTP)

diff:	clean
	wget -q -N $F
	tar zxf $A
	diff $D .

# eof
