import cpp

from MacroInvocation mcall, Macro m
where mcall.getMacro() = m
and (m.getName() = "ntohs"
or m.getName() = "ntohl"
or m.getName() = "ntohll")
select mcall
