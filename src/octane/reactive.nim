type Reactive[T] = proc(): T | proc(nextValue: T): T
proc reactive*[T](value: T): Reactive[T] {.importcpp: """sinuous.o(#)""", nodecl.}


