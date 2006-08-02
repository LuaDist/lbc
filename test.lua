-- test bc library

------------------------------------------------------------------------------
print(bc.version)

------------------------------------------------------------------------------
print""
print"Pi algorithm of order 4"

bc.digits(65)
PI=bc.number"3.1415926535897932384626433832795028841971693993751058209749445923078164062862090"

-- http://pauillac.inria.fr/algo/bsolve/constant/pi/pi.html
function A2()
 local x=bc.sqrt(2)
 local p=2+x
 local y=bc.sqrt(x)
 print(-1,p)
 x=(y+1/y)/2
 p=p*(x+1)/(y+1)
 print(0,p)
 for i=1,20 do
  local P=p
  local t=bc.sqrt(x)
  y=(y*t+1/t)/(y+1)
  x=(t+1/t)/2
  p=p*(x+1)/(y+1)
  print(i,p)
  if p==P then break end
 end
 return p
end

function bc.abs(x) if bc.isneg(x) then return -x else return x end end

p=A2()
print("exact",PI)
print("-",bc.abs(PI-p))

------------------------------------------------------------------------------
print""
print"Square root of 2"

function mysqrt(x)
 local y,z=x,x
 repeat z,y=y,(y+x/y)/2 until z==y
 return y
end

print("f math",math.sqrt(2))
print("f mine",mysqrt(2))
a=bc.sqrt(2) print("B sqrt",a)
b=mysqrt(bc.number(2)) print("B mine",b)
R=bc.number"1.414213562373095048801688724209698078569671875376948073176679737990732478462107038850387534327641573"
print("exact",R)
print(a==b,a<b,a>b,bc.compare(a,b))

------------------------------------------------------------------------------
print""
print"Fibonacci numbers as digits in fraction"

x=99989999
bc.digits(68)
a=bc.div(1,x)
s=bc.tostring(a)
print("1/"..x.." =")
print("",s)
s=string.gsub(s,"0(%d%d%d)"," %1")
print("",s)

------------------------------------------------------------------------------
print""
print"Factorials"

function factorial(n,f)
 for i=2,n do f=f*i end
 return f
end

one=bc.number(1)
for i=1,30 do
 print(i,factorial(i,1),factorial(i,one))
end

------------------------------------------------------------------------------
print""
print"Comparisons"

bc.digits(4)
a=bc.div(4,2)
b=bc.number(1)
print("a","b","a==b","a<b","a>b","bc.compare(a,b)")
print(a,b,a==b,a<b,a>b,bc.compare(a,b))
b=b+1
print(a,b,a==b,a<b,a>b,bc.compare(a,b))
b=b+1
print(a,b,a==b,a<b,a>b,bc.compare(a,b))

------------------------------------------------------------------------------
print""
print(bc.version)

do return end	-------------------------------------------------------------

bc.digits(60)
print(bc.div(143,7))
print(bc.mod(143.2,7))
print(bc.mod(143,7))
print(bc.mod(143,7.5))

