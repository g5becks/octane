import sugar
type Reactive*[T] = () -> T | (T) -> T
proc reactive*[T](value: T): Reactive[T] {.importcpp: """sinuous.o(#)""", nodecl.}

proc computed*[T: () -> auto](observer: T): T {.
    importcpp: """sinuous.computed(#)""", nodecl.}

proc subscribe*[T](observer: () -> T): () -> void {.
    importcpp: """sinuous.subscribe(#)""", nodecl.}

proc unsubscribe*[T](observer: () -> T): void {.
    importcpp: """sinuous.unsubscribe(#)""", nodecl.}

proc isListening*(): bool {.
    importcpp: """sinuous.isLisenting()""", nodecl.}

proc root*[T](fn: () -> T): T {.
    importcpp: """sinuous.root(#)""", nodecl.}

proc sample*[T](fn: () -> T): T {.
    importcpp: """sinuous.sample(#)""", nodecl.}

proc transaction[T](fn: () -> T): T {.
    importcpp: """sinuous.transaction(#)""", nodecl.}
