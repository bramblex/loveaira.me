module Data.DOM.Tags where

import Prelude (Unit(), ($), unit)
import Data.Maybe
import Control.Monad.Free

import Data.DOM.Type

type Template = Content Unit

text :: String -> Template
text str = liftF $ TextContent str unit

elem :: Element -> Template
elem e = liftF $ ElementContent e unit

-- Normal Tags --

a :: Array Attribute -> Template -> Template
a attr cont = elem $ element "a" attr (Just cont)

abbr :: Array Attribute -> Template -> Template
abbr attr cont = elem $ element "abbr" attr (Just cont)

acronym :: Array Attribute -> Template -> Template
acronym attr cont = elem $ element "acronym" attr (Just cont)

address :: Array Attribute -> Template -> Template
address attr cont = elem $ element "address" attr (Just cont)

applet :: Array Attribute -> Template -> Template
applet attr cont = elem $ element "applet" attr (Just cont)

article :: Array Attribute -> Template -> Template
article attr cont = elem $ element "article" attr (Just cont)

aside :: Array Attribute -> Template -> Template
aside attr cont = elem $ element "aside" attr (Just cont)

audio :: Array Attribute -> Template -> Template
audio attr cont = elem $ element "audio" attr (Just cont)

b :: Array Attribute -> Template -> Template
b attr cont = elem $ element "b" attr (Just cont)

basefont :: Array Attribute -> Template -> Template
basefont attr cont = elem $ element "basefont" attr (Just cont)

bdi :: Array Attribute -> Template -> Template
bdi attr cont = elem $ element "bdi" attr (Just cont)

bdo :: Array Attribute -> Template -> Template
bdo attr cont = elem $ element "bdo" attr (Just cont)

big :: Array Attribute -> Template -> Template
big attr cont = elem $ element "big" attr (Just cont)

blockquote :: Array Attribute -> Template -> Template
blockquote attr cont = elem $ element "blockquote" attr (Just cont)

body :: Array Attribute -> Template -> Template
body attr cont = elem $ element "body" attr (Just cont)

button :: Array Attribute -> Template -> Template
button attr cont = elem $ element "button" attr (Just cont)

canvas :: Array Attribute -> Template -> Template
canvas attr cont = elem $ element "canvas" attr (Just cont)

caption :: Array Attribute -> Template -> Template
caption attr cont = elem $ element "caption" attr (Just cont)

center :: Array Attribute -> Template -> Template
center attr cont = elem $ element "center" attr (Just cont)

cite :: Array Attribute -> Template -> Template
cite attr cont = elem $ element "cite" attr (Just cont)

code :: Array Attribute -> Template -> Template
code attr cont = elem $ element "code" attr (Just cont)

colgroup :: Array Attribute -> Template -> Template
colgroup attr cont = elem $ element "colgroup" attr (Just cont)

command :: Array Attribute -> Template -> Template
command attr cont = elem $ element "command" attr (Just cont)

datalist :: Array Attribute -> Template -> Template
datalist attr cont = elem $ element "datalist" attr (Just cont)

dd :: Array Attribute -> Template -> Template
dd attr cont = elem $ element "dd" attr (Just cont)

del :: Array Attribute -> Template -> Template
del attr cont = elem $ element "del" attr (Just cont)

details :: Array Attribute -> Template -> Template
details attr cont = elem $ element "details" attr (Just cont)

dir :: Array Attribute -> Template -> Template
dir attr cont = elem $ element "dir" attr (Just cont)

div :: Array Attribute -> Template -> Template
div attr cont = elem $ element "div" attr (Just cont)

dfn :: Array Attribute -> Template -> Template
dfn attr cont = elem $ element "dfn" attr (Just cont)

dialog :: Array Attribute -> Template -> Template
dialog attr cont = elem $ element "dialog" attr (Just cont)

dl :: Array Attribute -> Template -> Template
dl attr cont = elem $ element "dl" attr (Just cont)

dt :: Array Attribute -> Template -> Template
dt attr cont = elem $ element "dt" attr (Just cont)

em :: Array Attribute -> Template -> Template
em attr cont = elem $ element "em" attr (Just cont)

fieldset :: Array Attribute -> Template -> Template
fieldset attr cont = elem $ element "fieldset" attr (Just cont)

figcaption :: Array Attribute -> Template -> Template
figcaption attr cont = elem $ element "figcaption" attr (Just cont)

figure :: Array Attribute -> Template -> Template
figure attr cont = elem $ element "figure" attr (Just cont)

font :: Array Attribute -> Template -> Template
font attr cont = elem $ element "font" attr (Just cont)

footer :: Array Attribute -> Template -> Template
footer attr cont = elem $ element "footer" attr (Just cont)

form :: Array Attribute -> Template -> Template
form attr cont = elem $ element "form" attr (Just cont)

frame :: Array Attribute -> Template -> Template
frame attr cont = elem $ element "frame" attr (Just cont)

frameset :: Array Attribute -> Template -> Template
frameset attr cont = elem $ element "frameset" attr (Just cont)

h1 :: Array Attribute -> Template -> Template
h1 attr cont = elem $ element "h1" attr (Just cont)

h2 :: Array Attribute -> Template -> Template
h2 attr cont = elem $ element "h2" attr (Just cont)

h3 :: Array Attribute -> Template -> Template
h3 attr cont = elem $ element "h3" attr (Just cont)

h4 :: Array Attribute -> Template -> Template
h4 attr cont = elem $ element "h4" attr (Just cont)

h5 :: Array Attribute -> Template -> Template
h5 attr cont = elem $ element "h5" attr (Just cont)

h6 :: Array Attribute -> Template -> Template
h6 attr cont = elem $ element "h6" attr (Just cont)

head :: Array Attribute -> Template -> Template
head attr cont = elem $ element "head" attr (Just cont)

header :: Array Attribute -> Template -> Template
header attr cont = elem $ element "header" attr (Just cont)

html :: Array Attribute -> Template -> Template
html attr cont = elem $ element "html" attr (Just cont)

i :: Array Attribute -> Template -> Template
i attr cont = elem $ element "i" attr (Just cont)

iframe :: Array Attribute -> Template -> Template
iframe attr cont = elem $ element "iframe" attr (Just cont)


ins :: Array Attribute -> Template -> Template
ins attr cont = elem $ element "ins" attr (Just cont)

isindex :: Array Attribute -> Template -> Template
isindex attr cont = elem $ element "isindex" attr (Just cont)

kbd :: Array Attribute -> Template -> Template
kbd attr cont = elem $ element "kbd" attr (Just cont)

label :: Array Attribute -> Template -> Template
label attr cont = elem $ element "label" attr (Just cont)

legend :: Array Attribute -> Template -> Template
legend attr cont = elem $ element "legend" attr (Just cont)

li :: Array Attribute -> Template -> Template
li attr cont = elem $ element "li" attr (Just cont)

map :: Array Attribute -> Template -> Template
map attr cont = elem $ element "map" attr (Just cont)

mark :: Array Attribute -> Template -> Template
mark attr cont = elem $ element "mark" attr (Just cont)

menu :: Array Attribute -> Template -> Template
menu attr cont = elem $ element "menu" attr (Just cont)

menuitem :: Array Attribute -> Template -> Template
menuitem attr cont = elem $ element "menuitem" attr (Just cont)

meter :: Array Attribute -> Template -> Template
meter attr cont = elem $ element "meter" attr (Just cont)

nav :: Array Attribute -> Template -> Template
nav attr cont = elem $ element "nav" attr (Just cont)

noframes :: Array Attribute -> Template -> Template
noframes attr cont = elem $ element "noframes" attr (Just cont)

noscript :: Array Attribute -> Template -> Template
noscript attr cont = elem $ element "noscript" attr (Just cont)

object :: Array Attribute -> Template -> Template
object attr cont = elem $ element "object" attr (Just cont)

ol :: Array Attribute -> Template -> Template
ol attr cont = elem $ element "ol" attr (Just cont)

optgroup :: Array Attribute -> Template -> Template
optgroup attr cont = elem $ element "optgroup" attr (Just cont)

option :: Array Attribute -> Template -> Template
option attr cont = elem $ element "option" attr (Just cont)

output :: Array Attribute -> Template -> Template
output attr cont = elem $ element "output" attr (Just cont)

p :: Array Attribute -> Template -> Template
p attr cont = elem $ element "p" attr (Just cont)

pre :: Array Attribute -> Template -> Template
pre attr cont = elem $ element "pre" attr (Just cont)

progress :: Array Attribute -> Template -> Template
progress attr cont = elem $ element "progress" attr (Just cont)

q :: Array Attribute -> Template -> Template
q attr cont = elem $ element "q" attr (Just cont)

rp :: Array Attribute -> Template -> Template
rp attr cont = elem $ element "rp" attr (Just cont)

rt :: Array Attribute -> Template -> Template
rt attr cont = elem $ element "rt" attr (Just cont)

ruby :: Array Attribute -> Template -> Template
ruby attr cont = elem $ element "ruby" attr (Just cont)

s :: Array Attribute -> Template -> Template
s attr cont = elem $ element "s" attr (Just cont)

samp :: Array Attribute -> Template -> Template
samp attr cont = elem $ element "samp" attr (Just cont)

script :: Array Attribute -> Template -> Template
script attr cont = elem $ element "script" attr (Just cont)

section :: Array Attribute -> Template -> Template
section attr cont = elem $ element "section" attr (Just cont)

select :: Array Attribute -> Template -> Template
select attr cont = elem $ element "select" attr (Just cont)

small :: Array Attribute -> Template -> Template
small attr cont = elem $ element "small" attr (Just cont)

span :: Array Attribute -> Template -> Template
span attr cont = elem $ element "span" attr (Just cont)

strike :: Array Attribute -> Template -> Template
strike attr cont = elem $ element "strike" attr (Just cont)

strong :: Array Attribute -> Template -> Template
strong attr cont = elem $ element "strong" attr (Just cont)

style :: Array Attribute -> Template -> Template
style attr cont = elem $ element "style" attr (Just cont)

sub :: Array Attribute -> Template -> Template
sub attr cont = elem $ element "sub" attr (Just cont)

summary :: Array Attribute -> Template -> Template
summary attr cont = elem $ element "summary" attr (Just cont)

sup :: Array Attribute -> Template -> Template
sup attr cont = elem $ element "sup" attr (Just cont)

table :: Array Attribute -> Template -> Template
table attr cont = elem $ element "table" attr (Just cont)

tbody :: Array Attribute -> Template -> Template
tbody attr cont = elem $ element "tbody" attr (Just cont)

td :: Array Attribute -> Template -> Template
td attr cont = elem $ element "td" attr (Just cont)

textarea :: Array Attribute -> Template -> Template
textarea attr cont = elem $ element "textarea" attr (Just cont)

tfoot :: Array Attribute -> Template -> Template
tfoot attr cont = elem $ element "tfoot" attr (Just cont)

th :: Array Attribute -> Template -> Template
th attr cont = elem $ element "th" attr (Just cont)

thead :: Array Attribute -> Template -> Template
thead attr cont = elem $ element "thead" attr (Just cont)

time :: Array Attribute -> Template -> Template
time attr cont = elem $ element "time" attr (Just cont)

title :: Array Attribute -> Template -> Template
title attr cont = elem $ element "title" attr (Just cont)

tr :: Array Attribute -> Template -> Template
tr attr cont = elem $ element "tr" attr (Just cont)

tt :: Array Attribute -> Template -> Template
tt attr cont = elem $ element "tt" attr (Just cont)

u :: Array Attribute -> Template -> Template
u attr cont = elem $ element "u" attr (Just cont)

ul :: Array Attribute -> Template -> Template
ul attr cont = elem $ element "ul" attr (Just cont)

var :: Array Attribute -> Template -> Template
var attr cont = elem $ element "var" attr (Just cont)

video :: Array Attribute -> Template -> Template
video attr cont = elem $ element "video" attr (Just cont)

xmp :: Array Attribute -> Template -> Template
xmp attr cont = elem $ element "xmp" attr (Just cont)

-- Self Closing Tags --

area :: Array Attribute -> Template
area attr = elem $ element "area" attr Nothing

base :: Array Attribute -> Template
base attr = elem $ element "base" attr Nothing

br :: Array Attribute -> Template
br attr = elem $ element "br" attr Nothing

col :: Array Attribute -> Template
col attr = elem $ element "col" attr Nothing

embed :: Array Attribute -> Template
embed attr = elem $ element "embed" attr Nothing

hr :: Array Attribute -> Template
hr attr = elem $ element "hr" attr Nothing

img :: Array Attribute -> Template
img attr = elem $ element "img" attr Nothing

input :: Array Attribute -> Template
input attr = elem $ element "input" attr Nothing

keygen :: Array Attribute -> Template
keygen attr = elem $ element "keygen" attr Nothing

link :: Array Attribute -> Template
link attr = elem $ element "link" attr Nothing

meta :: Array Attribute -> Template
meta attr = elem $ element "meta" attr Nothing

param :: Array Attribute -> Template
param attr = elem $ element "param" attr Nothing

source :: Array Attribute -> Template
source attr = elem $ element "source" attr Nothing

track :: Array Attribute -> Template
track attr = elem $ element "track" attr Nothing

wbr :: Array Attribute -> Template
wbr attr = elem $ element "wbr" attr Nothing
