import dom
import options
proc h*(kind: cstring, props: any, children: varargs[Node | cstring]): Node {.
    importcpp: """sinuous.h(#, #, #)""", nodecl.}

proc hf(kind: string, props: any, children: varargs[Node | string]): Node =
  var kids: seq[cstring] = @[]
  for kid in children:
    if kid is string:
      kids.add(cstring(kid))
    result = h(cstring(kind), props, kids)
type SomeAttribute = ref object
  id: int

type ElementChild = Node | proc | ref object | tuple | string | int | bool | Option

type ElementChildren = seq[ElementChild] | ElementChild

type Component = proc(props: any, children: varargs[ElementChildren]): Node |
    proc(children: varargs[ElementChildren])

let view* = proc(): Node =
  result = hf("h1", SomeAttribute(id: 1), "hello nim!")
