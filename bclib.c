/*
* bclib.c
* bc interface to Lua
* lhf@tecgraf.puc-rio.br
* 19 Feb 2002 09:39:07
* This code is hereby placed in the public domain.
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>

#include "config.h"
#include "number.h"
#include "lua.h"

static int BIGNUMBER;
static int DIGITS;

void bc_error (char *mesg, ...)
{
  va_list args;

  fprintf (stderr, "bclib error: ");
  va_start (args, mesg);
  vfprintf (stderr, mesg, args);
  va_end (args);
  fprintf (stderr, "\n");
}

void bc_warn (char *mesg, ...)
{
  va_list args;

  fprintf (stderr, "bclib warning: ");
  va_start (args, mesg);
  vfprintf (stderr, mesg, args);
  va_end (args);
  fprintf (stderr, "\n");
}

void bc_nomemory(void)
{
  bc_error("not enough memory");
}

static bc_num Bget(lua_State *L, int i)
{
 if (lua_tag(L,i)==BIGNUMBER)
  return lua_touserdata(L,i);
 else
 {
  const char* s=lua_tostring(L,i);
  bc_num x=NULL;
  bc_str2num(&x,s?s:"0",DIGITS);
  return x;
 }
}

static int Bdigits(lua_State *L)
{
 if (lua_gettop(L)==0)
 {
  lua_pushnumber(L,DIGITS);
  return 1;
 }
 else
 {
  DIGITS=lua_tonumber(L,1);
  return 0;
 }
}

static int Bstring(lua_State *L)
{
 bc_num a=Bget(L,1);
 char* s=bc_num2str(a);
 lua_pushstring(L,s);
 free(s);
 return 1;
}

static int Bnumber(lua_State *L)
{
 bc_num a=Bget(L,1);
 lua_pushusertag(L,a,BIGNUMBER);
 return 1;
}

static int Badd(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_num b=Bget(L,2);
 bc_num c=NULL;
 bc_add(a,b,&c,DIGITS);
 lua_pushusertag(L,c,BIGNUMBER);
 return 1;
}

static int Bsub(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_num b=Bget(L,2);
 bc_num c=NULL;
 bc_sub(a,b,&c,DIGITS);
 lua_pushusertag(L,c,BIGNUMBER);
 return 1;
}

static int Bmul(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_num b=Bget(L,2);
 bc_num c=NULL;
 bc_multiply(a,b,&c,DIGITS);
 lua_pushusertag(L,c,BIGNUMBER);
 return 1;
}

static int Bdiv(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_num b=Bget(L,2);
 bc_num c=NULL;
 if (bc_divide(a,b,&c,DIGITS)==0)
  lua_pushusertag(L,c,BIGNUMBER);
 else
  lua_pushnil(L);
 return 1;
}

static int Bmod(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_num b=Bget(L,2);
 bc_num c=NULL;
 if (bc_modulo(a,b,&c,DIGITS)==0)
  lua_pushusertag(L,c,BIGNUMBER);
 else
  lua_pushnil(L);
 return 1;
}

static int Bpow(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_num b=Bget(L,2);
 bc_num c=NULL;
 bc_raise(a,b,&c,DIGITS);
 lua_pushusertag(L,c,BIGNUMBER);
 return 1;
}

static int Bsqrt(lua_State *L)
{
 bc_num a=Bget(L,1);
 if (bc_sqrt(&a,DIGITS)!=0)
  lua_pushusertag(L,a,BIGNUMBER);
 else
  lua_pushnil(L);
 return 1;
}

static int Bgc(lua_State *L)
{
 bc_num a=Bget(L,1);
 bc_free_num(&a);
 return 0;
}

int lua_bclibopen(lua_State *L)
{
 BIGNUMBER=lua_newtag(L);
 lua_pushcfunction(L,Bgc); lua_settagmethod(L,BIGNUMBER,"gc");
 lua_register(L,"Bdigits",Bdigits);
 lua_register(L,"Bstring",Bstring);
 lua_register(L,"Bnumber",Bnumber);
 lua_register(L,"Badd",Badd);
 lua_register(L,"Bsub",Bsub);
 lua_register(L,"Bmul",Bmul);
 lua_register(L,"Bdiv",Bdiv);
 lua_register(L,"Bmod",Bmod);
 lua_register(L,"Bpow",Bpow);
 lua_register(L,"Bsqrt",Bsqrt);
 bc_init_numbers();
 return 0;
}
