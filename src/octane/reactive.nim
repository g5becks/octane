type Reactive[T] = proc(): T | proc(nextValue: T): T
proc reactive*[T](value: T): Reactive[T] {.importcpp: """sinuous.o(#)""", nodecl.}

proc computed*[T: proc(): auto](observer: T): T {.
    importcpp: """sinuous.computed(#)""".}

proc subscribe[T](observer: proc(): T): proc(): void {.
    importcpp: """sinuous.subscribe(#)""".}
