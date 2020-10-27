import dom

proc append*(target: Node, node: Node) =
    target.appendChild(node)


proc insert*(target: Node, node: Node, anchor: Node)=
    target.insertBefore(node, if anchor.isNil: nil else: anchor)

proc detach*(node: Node)=
    node.parentNode.removeChild(node)

proc element*(name: cstring): Element =
    result = document.createElement(name)

#[
proc destroyEach(iterations: seq[any], detaching: any) =
    for i in low(iterations)..<high(iterations):
        if not iterations[i].isNil
]#


type HtmlTag* = ref object
    e: Element
    n: seq[Node]
    t: Element
    a: Element

proc newHtmlTag*(anchor: Element = nil): HtmlTag =
    result = HtmlTag(a: anchor, e: nil, n: @[])


proc h*(self: HtmlTag ,html: cstring) =
    self.e.innerHTML = html
    self.n = self.e.childNodes

proc m*(self: HtmlTag, html: cstring, target: Element, anchor: Element = nil): void =
    if self.e.isNil:
        self.e = element(target.nodeName)
        self.t = target
        self.h(html)

proc i*(self: HtmlTag, anchor: Node): void =
    for i in low(self.n)..<high(self.n):
        insert(self.t, self.n[i], anchor)

proc d*(self: HtmlTag) =
    for i in self.n:
        detach(i)
proc p*(self: HtmlTag, html: cstring) =
    self.d()
    self.h(html)
    self.i(self.a)
