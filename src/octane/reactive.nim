import sugar
type Reactive[T] = proc(): T | proc(nextValue: T): T
proc reactive*[T](value: T): Reactive[T] {.importcpp: """sinuous.o(#)""", nodecl.}

proc computed*[T: proc(): auto](observer: T): T {.
    importcpp: """sinuous.computed(#)""", nodecl.}

proc subscribe*[T](observer: proc(): T): () -> void {.
    importcpp: """sinuous.subscribe(#)""", nodecl.}

proc unsubscribe*[T](observer: () -> T): void {.
    importcpp: """sinuous.unsubscribe(#)""", nodecl.}

proc isListening*(): bool {.
    importcpp: """sinuous.isLisenting()""", nodecl.}
