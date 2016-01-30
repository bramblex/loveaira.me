module Data.DOM.Attributes where

import Prelude ((++))
import Data.DOM.Type

newtype AttributeKey = AttributeKey String

(:=) :: AttributeKey -> String -> Attribute
(:=) (AttributeKey key) val = Attribute { key: key , val: val}

-- Normal Attributes --
accept :: AttributeKey
accept = AttributeKey "accept"

accept_accept :: AttributeKey
accept_accept = AttributeKey "accept-charset"

accesskey :: AttributeKey
accesskey = AttributeKey "accesskey"

action :: AttributeKey
action = AttributeKey "action"

align :: AttributeKey
align = AttributeKey "align"

alt :: AttributeKey
alt = AttributeKey "alt"

autocomplete :: AttributeKey
autocomplete = AttributeKey "autocomplete"

autosave :: AttributeKey
autosave = AttributeKey "autosave"

bgcolor :: AttributeKey
bgcolor = AttributeKey "bgcolor"

border :: AttributeKey
border = AttributeKey "border"

buffered :: AttributeKey
buffered = AttributeKey "buffered"

challenge :: AttributeKey
challenge = AttributeKey "challenge"

charset :: AttributeKey
charset = AttributeKey "charset"

cite :: AttributeKey
cite = AttributeKey "cite"

_class :: AttributeKey
_class = AttributeKey "class"

code :: AttributeKey
code = AttributeKey "code"

codebase :: AttributeKey
codebase = AttributeKey "codebase"

color :: AttributeKey
color = AttributeKey "color"

cols :: AttributeKey
cols = AttributeKey "cols"

colspan :: AttributeKey
colspan = AttributeKey "colspan"

content :: AttributeKey
content = AttributeKey "content"

contenteditable :: AttributeKey
contenteditable = AttributeKey "contenteditable"

contextmenu :: AttributeKey
contextmenu = AttributeKey "contextmenu"

controls :: AttributeKey
controls = AttributeKey "controls"

coords :: AttributeKey
coords = AttributeKey "coords"

datetime :: AttributeKey
datetime = AttributeKey "datetime"

_default :: AttributeKey
_default = AttributeKey "default"

dir :: AttributeKey
dir = AttributeKey "dir"

dirname :: AttributeKey
dirname = AttributeKey "dirname"

download :: AttributeKey
download = AttributeKey "download"

draggable :: AttributeKey
draggable = AttributeKey "draggable"

dropzone :: AttributeKey
dropzone = AttributeKey "dropzone"

enctype :: AttributeKey
enctype = AttributeKey "enctype"

for :: AttributeKey
for = AttributeKey "for"

form :: AttributeKey
form = AttributeKey "form"

formaction :: AttributeKey
formaction = AttributeKey "formaction"

headers :: AttributeKey
headers = AttributeKey "headers"

height :: AttributeKey
height = AttributeKey "height"

high :: AttributeKey
high = AttributeKey "high"

href :: AttributeKey
href = AttributeKey "href"

hreflang :: AttributeKey
hreflang = AttributeKey "hreflang"

http_http :: AttributeKey
http_http = AttributeKey "http-equiv"

icon :: AttributeKey
icon = AttributeKey "icon"

id :: AttributeKey
id = AttributeKey "id"

itemprop :: AttributeKey
itemprop = AttributeKey "itemprop"

keytype :: AttributeKey
keytype = AttributeKey "keytype"

kind :: AttributeKey
kind = AttributeKey "kind"

label :: AttributeKey
label = AttributeKey "label"

lang :: AttributeKey
lang = AttributeKey "lang"

language :: AttributeKey
language = AttributeKey "language"

list :: AttributeKey
list = AttributeKey "list"

low :: AttributeKey
low = AttributeKey "low"

manifest :: AttributeKey
manifest = AttributeKey "manifest"

max :: AttributeKey
max = AttributeKey "max"

maxlength :: AttributeKey
maxlength = AttributeKey "maxlength"

media :: AttributeKey
media = AttributeKey "media"

method :: AttributeKey
method = AttributeKey "method"

min :: AttributeKey
min = AttributeKey "min"

name :: AttributeKey
name = AttributeKey "name"

open :: AttributeKey
open = AttributeKey "open"

optimum :: AttributeKey
optimum = AttributeKey "optimum"

pattern :: AttributeKey
pattern = AttributeKey "pattern"

ping :: AttributeKey
ping = AttributeKey "ping"

placeholder :: AttributeKey
placeholder = AttributeKey "placeholder"

poster :: AttributeKey
poster = AttributeKey "poster"

preload :: AttributeKey
preload = AttributeKey "preload"

radiogroup :: AttributeKey
radiogroup = AttributeKey "radiogroup"

rel :: AttributeKey
rel = AttributeKey "rel"

required :: AttributeKey
required = AttributeKey "required"

reversed :: AttributeKey
reversed = AttributeKey "reversed"

rows :: AttributeKey
rows = AttributeKey "rows"

rowspan :: AttributeKey
rowspan = AttributeKey "rowspan"

sandbox :: AttributeKey
sandbox = AttributeKey "sandbox"

scope :: AttributeKey
scope = AttributeKey "scope"

scoped :: AttributeKey
scoped = AttributeKey "scoped"

seamless :: AttributeKey
seamless = AttributeKey "seamless"

shape :: AttributeKey
shape = AttributeKey "shape"

size :: AttributeKey
size = AttributeKey "size"

sizes :: AttributeKey
sizes = AttributeKey "sizes"

span :: AttributeKey
span = AttributeKey "span"

spellcheck :: AttributeKey
spellcheck = AttributeKey "spellcheck"

src :: AttributeKey
src = AttributeKey "src"

srcdoc :: AttributeKey
srcdoc = AttributeKey "srcdoc"

srclang :: AttributeKey
srclang = AttributeKey "srclang"

srcset :: AttributeKey
srcset = AttributeKey "srcset"

start :: AttributeKey
start = AttributeKey "start"

step :: AttributeKey
step = AttributeKey "step"

style :: AttributeKey
style = AttributeKey "style"

summary :: AttributeKey
summary = AttributeKey "summary"

tabindex :: AttributeKey
tabindex = AttributeKey "tabindex"

target :: AttributeKey
target = AttributeKey "target"

title :: AttributeKey
title = AttributeKey "title"

_type :: AttributeKey
_type = AttributeKey "type"

usemap :: AttributeKey
usemap = AttributeKey "usemap"

value :: AttributeKey
value = AttributeKey "value"

width :: AttributeKey
width = AttributeKey "width"

wrap :: AttributeKey
wrap = AttributeKey "wrap"

-- Data Attributes --

_data_ :: String -> AttributeKey
_data_ key = AttributeKey ("data-" ++ key)

_data :: AttributeKey
_data = AttributeKey "data"

-- Boolean Attributes --

async :: Attribute
async = BooleanAttr { key: "async" }

selected :: Attribute
selected = BooleanAttr { key: "selected" }

autofocus :: Attribute
autofocus = BooleanAttr { key: "autofocus" }

checked :: Attribute
checked = BooleanAttr { key: "checked" }

disabled :: Attribute
disabled = BooleanAttr { key: "disabled" }

multiple :: Attribute
multiple = BooleanAttr { key: "multiple" }

readonly :: Attribute
readonly = BooleanAttr { key: "readonly" }

novalidate :: Attribute
novalidate = BooleanAttr { key: "novalidate" }

autoplay :: Attribute
autoplay = BooleanAttr { key: "autoplay" }

hidden :: Attribute
hidden = BooleanAttr { key: "hidden" }

loop :: Attribute
loop = BooleanAttr { key: "loop" }

defer :: Attribute
defer = BooleanAttr { key: "defer" }

ismap :: Attribute
ismap = BooleanAttr { key: "ismap" }

-- Event Handler Attributes --

onabort :: AttributeKey
onabort = AttributeKey "onabort"

onautocomplete :: AttributeKey
onautocomplete = AttributeKey "onautocomplete"

onautocompleteerror :: AttributeKey
onautocompleteerror = AttributeKey "onautocompleteerror"

onblur :: AttributeKey
onblur = AttributeKey "onblur"

oncancel :: AttributeKey
oncancel = AttributeKey "oncancel"

oncanp :: AttributeKey
oncanp = AttributeKey "oncanp"

oncanplaythrough :: AttributeKey
oncanplaythrough = AttributeKey "oncanplaythrough"

onchange :: AttributeKey
onchange = AttributeKey "onchange"

onclick :: AttributeKey
onclick = AttributeKey "onclick"

onclose :: AttributeKey
onclose = AttributeKey "onclose"

oncontextmenu :: AttributeKey
oncontextmenu = AttributeKey "oncontextmenu"

oncuechange :: AttributeKey
oncuechange = AttributeKey "oncuechange"

ondblclick :: AttributeKey
ondblclick = AttributeKey "ondblclick"

ondrag :: AttributeKey
ondrag = AttributeKey "ondrag"

ondragend :: AttributeKey
ondragend = AttributeKey "ondragend"

ondragenter :: AttributeKey
ondragenter = AttributeKey "ondragenter"

ondragexit :: AttributeKey
ondragexit = AttributeKey "ondragexit"

ondragleave :: AttributeKey
ondragleave = AttributeKey "ondragleave"

ondragover :: AttributeKey
ondragover = AttributeKey "ondragover"

ondragstart :: AttributeKey
ondragstart = AttributeKey "ondragstart"

ondrop :: AttributeKey
ondrop = AttributeKey "ondrop"

ondurationchange :: AttributeKey
ondurationchange = AttributeKey "ondurationchange"

onemptied :: AttributeKey
onemptied = AttributeKey "onemptied"

onended :: AttributeKey
onended = AttributeKey "onended"

onerror :: AttributeKey
onerror = AttributeKey "onerror"

onfocus :: AttributeKey
onfocus = AttributeKey "onfocus"

oninput :: AttributeKey
oninput = AttributeKey "oninput"

oninvalid :: AttributeKey
oninvalid = AttributeKey "oninvalid"

onkeydown :: AttributeKey
onkeydown = AttributeKey "onkeydown"

onkeypress :: AttributeKey
onkeypress = AttributeKey "onkeypress"

onkeyup :: AttributeKey
onkeyup = AttributeKey "onkeyup"

onload :: AttributeKey
onload = AttributeKey "onload"

onloadeddata :: AttributeKey
onloadeddata = AttributeKey "onloadeddata"

onloadedmetadata :: AttributeKey
onloadedmetadata = AttributeKey "onloadedmetadata"

onloadstart :: AttributeKey
onloadstart = AttributeKey "onloadstart"

onmousedown :: AttributeKey
onmousedown = AttributeKey "onmousedown"

onmouseenter :: AttributeKey
onmouseenter = AttributeKey "onmouseenter"

onmouseleave :: AttributeKey
onmouseleave = AttributeKey "onmouseleave"

onmousemove :: AttributeKey
onmousemove = AttributeKey "onmousemove"

onmouseout :: AttributeKey
onmouseout = AttributeKey "onmouseout"

onmouseover :: AttributeKey
onmouseover = AttributeKey "onmouseover"

onmouseup :: AttributeKey
onmouseup = AttributeKey "onmouseup"

onmousewheel :: AttributeKey
onmousewheel = AttributeKey "onmousewheel"

onpause :: AttributeKey
onpause = AttributeKey "onpause"

onplay :: AttributeKey
onplay = AttributeKey "onplay"

onplaying :: AttributeKey
onplaying = AttributeKey "onplaying"

onprogress :: AttributeKey
onprogress = AttributeKey "onprogress"

onratechange :: AttributeKey
onratechange = AttributeKey "onratechange"

onreset :: AttributeKey
onreset = AttributeKey "onreset"

onresize :: AttributeKey
onresize = AttributeKey "onresize"

onscroll :: AttributeKey
onscroll = AttributeKey "onscroll"

onseeked :: AttributeKey
onseeked = AttributeKey "onseeked"

onseeking :: AttributeKey
onseeking = AttributeKey "onseeking"

onselect :: AttributeKey
onselect = AttributeKey "onselect"

onshow :: AttributeKey
onshow = AttributeKey "onshow"

onsort :: AttributeKey
onsort = AttributeKey "onsort"

onstalled :: AttributeKey
onstalled = AttributeKey "onstalled"

onsubmit :: AttributeKey
onsubmit = AttributeKey "onsubmit"

onsuspend :: AttributeKey
onsuspend = AttributeKey "onsuspend"

ontimeupdate :: AttributeKey
ontimeupdate = AttributeKey "ontimeupdate"

ontoggle :: AttributeKey
ontoggle = AttributeKey "ontoggle"

onvolumechange :: AttributeKey
onvolumechange = AttributeKey "onvolumechange"

onwaiting :: AttributeKey
onwaiting = AttributeKey "onwaiting"
