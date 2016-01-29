module Data.DOM.Tag where

import Data.DOM.Type

-- Normal Tags --

a :: Array Attribute -> Content Unit -> Element
a attr cont = element "a" attr (Just cont)

abbr :: Array Attribute -> Content Unit -> Element
abbr attr cont = element "abbr" attr (Just cont)

acronym :: Array Attribute -> Content Unit -> Element
acronym attr cont = element "acronym" attr (Just cont)

address :: Array Attribute -> Content Unit -> Element
address attr cont = element "address" attr (Just cont)

applet :: Array Attribute -> Content Unit -> Element
applet attr cont = element "applet" attr (Just cont)

article :: Array Attribute -> Content Unit -> Element
article attr cont = element "article" attr (Just cont)

aside :: Array Attribute -> Content Unit -> Element
aside attr cont = element "aside" attr (Just cont)

audio :: Array Attribute -> Content Unit -> Element
audio attr cont = element "audio" attr (Just cont)

b :: Array Attribute -> Content Unit -> Element
b attr cont = element "b" attr (Just cont)

basefont :: Array Attribute -> Content Unit -> Element
basefont attr cont = element "basefont" attr (Just cont)

bdi :: Array Attribute -> Content Unit -> Element
bdi attr cont = element "bdi" attr (Just cont)

bdo :: Array Attribute -> Content Unit -> Element
bdo attr cont = element "bdo" attr (Just cont)

big :: Array Attribute -> Content Unit -> Element
big attr cont = element "big" attr (Just cont)

blockquote :: Array Attribute -> Content Unit -> Element
blockquote attr cont = element "blockquote" attr (Just cont)

body :: Array Attribute -> Content Unit -> Element
body attr cont = element "body" attr (Just cont)

button :: Array Attribute -> Content Unit -> Element
button attr cont = element "button" attr (Just cont)

canvas :: Array Attribute -> Content Unit -> Element
canvas attr cont = element "canvas" attr (Just cont)

caption :: Array Attribute -> Content Unit -> Element
caption attr cont = element "caption" attr (Just cont)

center :: Array Attribute -> Content Unit -> Element
center attr cont = element "center" attr (Just cont)

cite :: Array Attribute -> Content Unit -> Element
cite attr cont = element "cite" attr (Just cont)

code :: Array Attribute -> Content Unit -> Element
code attr cont = element "code" attr (Just cont)

colgroup :: Array Attribute -> Content Unit -> Element
colgroup attr cont = element "colgroup" attr (Just cont)

command :: Array Attribute -> Content Unit -> Element
command attr cont = element "command" attr (Just cont)

datalist :: Array Attribute -> Content Unit -> Element
datalist attr cont = element "datalist" attr (Just cont)

dd :: Array Attribute -> Content Unit -> Element
dd attr cont = element "dd" attr (Just cont)

del :: Array Attribute -> Content Unit -> Element
del attr cont = element "del" attr (Just cont)

details :: Array Attribute -> Content Unit -> Element
details attr cont = element "details" attr (Just cont)

dir :: Array Attribute -> Content Unit -> Element
dir attr cont = element "dir" attr (Just cont)

div :: Array Attribute -> Content Unit -> Element
div attr cont = element "div" attr (Just cont)

dfn :: Array Attribute -> Content Unit -> Element
dfn attr cont = element "dfn" attr (Just cont)

dialog :: Array Attribute -> Content Unit -> Element
dialog attr cont = element "dialog" attr (Just cont)

dl :: Array Attribute -> Content Unit -> Element
dl attr cont = element "dl" attr (Just cont)

dt :: Array Attribute -> Content Unit -> Element
dt attr cont = element "dt" attr (Just cont)

em :: Array Attribute -> Content Unit -> Element
em attr cont = element "em" attr (Just cont)

fieldset :: Array Attribute -> Content Unit -> Element
fieldset attr cont = element "fieldset" attr (Just cont)

figcaption :: Array Attribute -> Content Unit -> Element
figcaption attr cont = element "figcaption" attr (Just cont)

figure :: Array Attribute -> Content Unit -> Element
figure attr cont = element "figure" attr (Just cont)

font :: Array Attribute -> Content Unit -> Element
font attr cont = element "font" attr (Just cont)

footer :: Array Attribute -> Content Unit -> Element
footer attr cont = element "footer" attr (Just cont)

form :: Array Attribute -> Content Unit -> Element
form attr cont = element "form" attr (Just cont)

frame :: Array Attribute -> Content Unit -> Element
frame attr cont = element "frame" attr (Just cont)

frameset :: Array Attribute -> Content Unit -> Element
frameset attr cont = element "frameset" attr (Just cont)

h1 :: Array Attribute -> Content Unit -> Element
h1 attr cont = element "h1" attr (Just cont)
 to <h6>
head :: Array Attribute -> Content Unit -> Element
head attr cont = element "head" attr (Just cont)

header :: Array Attribute -> Content Unit -> Element
header attr cont = element "header" attr (Just cont)

html :: Array Attribute -> Content Unit -> Element
html attr cont = element "html" attr (Just cont)

i :: Array Attribute -> Content Unit -> Element
i attr cont = element "i" attr (Just cont)

iframe :: Array Attribute -> Content Unit -> Element
iframe attr cont = element "iframe" attr (Just cont)


ins :: Array Attribute -> Content Unit -> Element
ins attr cont = element "ins" attr (Just cont)

isindex :: Array Attribute -> Content Unit -> Element
isindex attr cont = element "isindex" attr (Just cont)

kbd :: Array Attribute -> Content Unit -> Element
kbd attr cont = element "kbd" attr (Just cont)

label :: Array Attribute -> Content Unit -> Element
label attr cont = element "label" attr (Just cont)

legend :: Array Attribute -> Content Unit -> Element
legend attr cont = element "legend" attr (Just cont)

li :: Array Attribute -> Content Unit -> Element
li attr cont = element "li" attr (Just cont)

map :: Array Attribute -> Content Unit -> Element
map attr cont = element "map" attr (Just cont)

mark :: Array Attribute -> Content Unit -> Element
mark attr cont = element "mark" attr (Just cont)

menu :: Array Attribute -> Content Unit -> Element
menu attr cont = element "menu" attr (Just cont)

menuitem :: Array Attribute -> Content Unit -> Element
menuitem attr cont = element "menuitem" attr (Just cont)

meter :: Array Attribute -> Content Unit -> Element
meter attr cont = element "meter" attr (Just cont)

nav :: Array Attribute -> Content Unit -> Element
nav attr cont = element "nav" attr (Just cont)

noframes :: Array Attribute -> Content Unit -> Element
noframes attr cont = element "noframes" attr (Just cont)

noscript :: Array Attribute -> Content Unit -> Element
noscript attr cont = element "noscript" attr (Just cont)

object :: Array Attribute -> Content Unit -> Element
object attr cont = element "object" attr (Just cont)

ol :: Array Attribute -> Content Unit -> Element
ol attr cont = element "ol" attr (Just cont)

optgroup :: Array Attribute -> Content Unit -> Element
optgroup attr cont = element "optgroup" attr (Just cont)

option :: Array Attribute -> Content Unit -> Element
option attr cont = element "option" attr (Just cont)

output :: Array Attribute -> Content Unit -> Element
output attr cont = element "output" attr (Just cont)

p :: Array Attribute -> Content Unit -> Element
p attr cont = element "p" attr (Just cont)

pre :: Array Attribute -> Content Unit -> Element
pre attr cont = element "pre" attr (Just cont)

progress :: Array Attribute -> Content Unit -> Element
progress attr cont = element "progress" attr (Just cont)

q :: Array Attribute -> Content Unit -> Element
q attr cont = element "q" attr (Just cont)

rp :: Array Attribute -> Content Unit -> Element
rp attr cont = element "rp" attr (Just cont)

rt :: Array Attribute -> Content Unit -> Element
rt attr cont = element "rt" attr (Just cont)

ruby :: Array Attribute -> Content Unit -> Element
ruby attr cont = element "ruby" attr (Just cont)

s :: Array Attribute -> Content Unit -> Element
s attr cont = element "s" attr (Just cont)

samp :: Array Attribute -> Content Unit -> Element
samp attr cont = element "samp" attr (Just cont)

script :: Array Attribute -> Content Unit -> Element
script attr cont = element "script" attr (Just cont)

section :: Array Attribute -> Content Unit -> Element
section attr cont = element "section" attr (Just cont)

select :: Array Attribute -> Content Unit -> Element
select attr cont = element "select" attr (Just cont)

small :: Array Attribute -> Content Unit -> Element
small attr cont = element "small" attr (Just cont)

span :: Array Attribute -> Content Unit -> Element
span attr cont = element "span" attr (Just cont)

strike :: Array Attribute -> Content Unit -> Element
strike attr cont = element "strike" attr (Just cont)

strong :: Array Attribute -> Content Unit -> Element
strong attr cont = element "strong" attr (Just cont)

style :: Array Attribute -> Content Unit -> Element
style attr cont = element "style" attr (Just cont)

sub :: Array Attribute -> Content Unit -> Element
sub attr cont = element "sub" attr (Just cont)

summary :: Array Attribute -> Content Unit -> Element
summary attr cont = element "summary" attr (Just cont)

sup :: Array Attribute -> Content Unit -> Element
sup attr cont = element "sup" attr (Just cont)

table :: Array Attribute -> Content Unit -> Element
table attr cont = element "table" attr (Just cont)

tbody :: Array Attribute -> Content Unit -> Element
tbody attr cont = element "tbody" attr (Just cont)

td :: Array Attribute -> Content Unit -> Element
td attr cont = element "td" attr (Just cont)

textarea :: Array Attribute -> Content Unit -> Element
textarea attr cont = element "textarea" attr (Just cont)

tfoot :: Array Attribute -> Content Unit -> Element
tfoot attr cont = element "tfoot" attr (Just cont)

th :: Array Attribute -> Content Unit -> Element
th attr cont = element "th" attr (Just cont)

thead :: Array Attribute -> Content Unit -> Element
thead attr cont = element "thead" attr (Just cont)

time :: Array Attribute -> Content Unit -> Element
time attr cont = element "time" attr (Just cont)

title :: Array Attribute -> Content Unit -> Element
title attr cont = element "title" attr (Just cont)

tr :: Array Attribute -> Content Unit -> Element
tr attr cont = element "tr" attr (Just cont)

tt :: Array Attribute -> Content Unit -> Element
tt attr cont = element "tt" attr (Just cont)

u :: Array Attribute -> Content Unit -> Element
u attr cont = element "u" attr (Just cont)

ul :: Array Attribute -> Content Unit -> Element
ul attr cont = element "ul" attr (Just cont)

var :: Array Attribute -> Content Unit -> Element
var attr cont = element "var" attr (Just cont)

video :: Array Attribute -> Content Unit -> Element
video attr cont = element "video" attr (Just cont)

xmp :: Array Attribute -> Content Unit -> Element
xmp attr cont = element "xmp" attr (Just cont)

-- Self Closing Tags --

area :: Array Attribute -> Element
area attr = element "area" attr Nothing

base :: Array Attribute -> Element
base attr = element "base" attr Nothing

br :: Array Attribute -> Element
br attr = element "br" attr Nothing

col :: Array Attribute -> Element
col attr = element "col" attr Nothing

embed :: Array Attribute -> Element
embed attr = element "embed" attr Nothing

hr :: Array Attribute -> Element
hr attr = element "hr" attr Nothing

img :: Array Attribute -> Element
img attr = element "img" attr Nothing

input :: Array Attribute -> Element
input attr = element "input" attr Nothing

keygen :: Array Attribute -> Element
keygen attr = element "keygen" attr Nothing

link :: Array Attribute -> Element
link attr = element "link" attr Nothing

meta :: Array Attribute -> Element
meta attr = element "meta" attr Nothing

param :: Array Attribute -> Element
param attr = element "param" attr Nothing

source :: Array Attribute -> Element
source attr = element "source" attr Nothing

track :: Array Attribute -> Element
track attr = element "track" attr Nothing

wbr :: Array Attribute -> Element
wbr attr = element "wbr" attr Nothing
