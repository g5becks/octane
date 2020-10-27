import dom


proc append*(target: Node, node: Node) =
    ## Append `node` to `target`.
    target.appendChild(node)

# Inserts
proc insert*(target: Node, node: Node, anchor: Node)=
    ## Inserts `node` before `anchor`.
    target.insertBefore(node, if anchor.isNil: nil else: anchor)

proc detach*(node: Node)=
    ## Removes `node` from dom.
    node.parentNode.removeChild(node)



proc element*(name: cstring): Element =
    ## Creates a new dom element.
    result = document.createElement(name)


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


proc destroyEach*(iterations: seq[HtmlTag], detaching: Node) =
    for i, v in iterations:
        if not v.isNil:
            v.d(detaching)