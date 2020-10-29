import dom
import reactive
import options

# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/shared.d.ts#L3
type ElementChild* = Node | proc | ref object | tuple | string | int | bool | Option

# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/shared.d.ts#L13
type ElementChildren* = seq[ElementChild] | ElementChild

type OrReactive*[T] = T | Reactive[T]
#[
type AllowObservable*[Props] =
]#

# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/src/index.d.ts#L14
type DomAttributes*[Target: EventTarget] = ref object
  children: ElementChildren

#[
type HTMCAttributes*[RefType: EventTarget] =
]#
type Component* = proc(props: any, children: varargs[ElementChildren]): Node |
    proc(children: varargs[ElementChildren])
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


let view* = proc(): Node =
  result = hf("h1", SomeAttribute(id: 1), "hello nim!")
