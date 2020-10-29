import dom
import reactive
import options


type ElementKind {.pure.} = enum
  html = "html", head = "head", base = "base", link = "link",
  meta = "meta", style = "style", title = "title", body = "body",
      address = "address", article = "article", aside = "aside",
      footer = "footer", header = "header", h1 = "h1", h2 = "h2", h3 = "h3",
      h4 = "h4", h5 = "h5", h6 = "h6", hgroup = "hgroup", main = "main",
      nav = "nav", section = "section", blockquote = "blockquote", dd = "dd",
      divv = "div", dl = "dl", dt = "dt", figcaption = "figcaption",
      figure = "figure", hr = "hr", li = "li", ol = "ol", p = "p", pre = "pre",
      ul = "ul", a = "a", abbr = "abbr", b = "b", bdi = "bdi", bdo = "bdo",
      br = "br", cite = "cite", code = "code", data = "data", dfn = "dfn",
      em = "em", i = "i", kbd = "kbd", mark = "mark", q = "q", rb = "rb",
      rp = "rp", rt = "rp", rtc = "rtc", ruby = "ruby", s = "s", samp = "samp",
          small = "small", span = "span", strong = "strong", sub = "sub",
          sup = "sup", time = "time", u = "u", varr = "var", wbr = "wbr",
              area = "area", audio = "audio", img = "img", map = "map",
              track = "track", video = "video", embed = "embed",
              iframe = "iframe", objectt = "object", param = "param",
              picture = "picture", source = "source", canvas = "canvas",
              noscript = "noscript", script = "script", del = "del",
              ins = "ins", caption = "caption", colgroup = "colgroup",
              table = "table", tbody = "tbody", td = "td", tfoot = "tfoot",
              th = "th", thead = "thead", tr = "tr", button = "button",
              datalist = "datalist", fieldset = "fieldset", form = "form",
              input = "input", label = "label", legend = "legend"


# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/shared.d.ts#L3
type ElementChild* = Node | proc | ref object | tuple | string | int | bool | Option

# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/shared.d.ts#L13
type ElementChildren* = seq[ElementChild] | ElementChild

type OrReactive*[T] = T | Reactive[T]
#[
type AllowObservable*[Props] =
]#

# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/src/index.d.ts#L14
type DomAttributes*[Target: EventTarget] = ref object of RootObj
  children*: ElementChildren


#[
type HTMLAttributes*[RefType: EventTarget] =
]#

# https://github.com/luwes/sinuous/blob/8561a6c91c061b58d14bf55dc91f74e162e35226/packages/sinuous/shared.d.ts#L15
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
