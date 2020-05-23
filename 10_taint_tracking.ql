/**
* @kind path-problem
*/

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph
 
class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    exists(MacroInvocation mcall, Macro m |
       mcall.getMacro() = m
       and (m.getName() = "ntohs"
       or m.getName() = "ntohl"
       or m.getName() = "ntohll")
       and    this = mcall.getExpr()    
    )    
  }
}
 
class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    exists(FunctionCall call | sink.asExpr() = call.getArgument(3))
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
