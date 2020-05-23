import cpp

from FunctionCall call,Function func
where call.getTarget() = func
and func.hasName("memcpy")
select call

