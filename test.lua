dofile"tm.lua"

function mysqrt(x)
 local n=ceil(log(Bdigits())/log(2))+1
 local y=x
 for i=1,n do y=(y+x/y)/2 end
 return y
end

Bdigits(50) a=Bsqrt(2) print(a)
Bdigits(50) c=mysqrt(Bnumber(2)) print(c)
Bdigits(20) b=Bnumber(tostring(a)) print(b)

Bdigits(53) print(Bdiv(1,998999))

exit()

print(Bsqrt(2))
c=Bdiv(1,23)
print(c)
print(Bstring(c))

print(Bdiv(143,7))
print(Bmod(143,7))

exit()

a=Bnumber(rad(180))
print(Bstring(a))
c=Bdiv(1,23)
print(c)
print(Bstring(c))

c=Bpow(2,123)
print(Bstring(c))

exit()

-- Arctan: Using the formula:
--     atan(x) = atan(c) + atan((x-c)/(1+xc)) for a small c (.2 here)
--  For under .2, use the series:
--	     atan(x) = x - x^3/3 + x^5/5 - x^7/7 + ... 

function Batan(x,n)
 local four=Bnumber(4)
 local y=Bmul(x,x)
 local z=x
 local t=x
 local a=t
 local j=1
 local A=a
 local b
 for i=2,n do
  j=j+2
  z=Bmul(z,y)
  t=Bdiv(z,Bnumber(j))
  if mod(i,2)==0 then a=Bsub(a,t) else a=Badd(a,t) end
b=Badd(a,A) b=Bmul(b,Bnumber(2))
  A=a
 end
print(Bstring(b))
end

Bdigits(70)
Batan(Bnumber(1),100)
print(4*rad(atan(1)))
