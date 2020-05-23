import cpp

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

from NetworkByteSwap n
select n, "Network byte swap" 
