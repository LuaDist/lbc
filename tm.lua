do
 local TAG=tag(Bnumber())
 settagmethod(TAG,"add",Badd)
 settagmethod(TAG,"sub",Bsub)
 settagmethod(TAG,"mul",Bmul)
 settagmethod(TAG,"div",Bdiv)
 settagmethod(TAG,"pow",Bpow)
 settagmethod(TAG,"unm",function (a) return Bsub(0,a) end)

 function tostring(x)
  if tag(x)==%TAG then return Bstring(x) else return %tostring(x) end
 end

end
