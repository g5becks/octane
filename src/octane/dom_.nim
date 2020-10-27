import dom
import sugar
import sequtils
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

# TODO figure out if this proc actually works
# Fix it if not
proc svgElement*(name: cstring): Element =
    ## create
    result = document.createElement(name)


proc text*(data: cstring): Node =
    ## Creates a text Node using `data`.
    result = document.createTextNode(data)

proc space*(): Node = text(" ")

proc listen*(node: EventTarget, event: cstring, handler: proc (ev: Event), opts: AddEventListenerOptions = AddEventListenerOptions()): proc() =
    node.addEventListener(event, handler, opts)
    () => node.removeEventListener(event, handler, opts)


proc attr*(node: Element, attribute: cstring, value: cstring = "") =
    if value == "":
        node.removeAttribute(attribute)
    elif node.getAttribute(attribute) != value:
        node.setAttribute(attribute, value)

proc children*(el: Element): seq[Node] =
    el.childNodes

proc claim_text*(nodes: seq[Node], data: cstring): Node =
    for i, v in nodes:
        if v.NodeType == 3:
            v.data = "" + data
            nodes.delete(i, 1)
            return nodes[0]
    return text(data)


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