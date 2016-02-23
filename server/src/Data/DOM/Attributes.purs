module Data.DOM.Attributes where

import Prelude ((++))
import Data.DOM.Type

newtype AttributeKey = AttributeKey String

(:=) :: AttributeKey -> String -> Attribute
(:=) (AttributeKey key) val = Attribute { key: key , val: val}

-- Normal Attributes --

a_accept :: AttributeKey
a_accept = AttributeKey "accept"

a_accept_accept :: AttributeKey
a_accept_accept = AttributeKey "accept-charset"

a_accesskey :: AttributeKey
a_accesskey = AttributeKey "accesskey"

a_action :: AttributeKey
a_action = AttributeKey "action"

a_align :: AttributeKey
a_align = AttributeKey "align"

a_alt :: AttributeKey
a_alt = AttributeKey "alt"

a_autocomplete :: AttributeKey
a_autocomplete = AttributeKey "autocomplete"

a_autosave :: AttributeKey
a_autosave = AttributeKey "autosave"

a_bgcolor :: AttributeKey
a_bgcolor = AttributeKey "bgcolor"

a_border :: AttributeKey
a_border = AttributeKey "border"

a_buffered :: AttributeKey
a_buffered = AttributeKey "buffered"

a_challenge :: AttributeKey
a_challenge = AttributeKey "challenge"

a_charset :: AttributeKey
a_charset = AttributeKey "charset"

a_cite :: AttributeKey
a_cite = AttributeKey "cite"

a_class :: AttributeKey
a_class = AttributeKey "class"

a_code :: AttributeKey
a_code = AttributeKey "code"

a_codebase :: AttributeKey
a_codebase = AttributeKey "codebase"

a_color :: AttributeKey
a_color = AttributeKey "color"

a_cols :: AttributeKey
a_cols = AttributeKey "cols"

a_colspan :: AttributeKey
a_colspan = AttributeKey "colspan"

a_content :: AttributeKey
a_content = AttributeKey "content"

a_contenteditable :: AttributeKey
a_contenteditable = AttributeKey "contenteditable"

a_contextmenu :: AttributeKey
a_contextmenu = AttributeKey "contextmenu"

a_controls :: AttributeKey
a_controls = AttributeKey "controls"

a_coords :: AttributeKey
a_coords = AttributeKey "coords"

a_datetime :: AttributeKey
a_datetime = AttributeKey "datetime"

a_default :: AttributeKey
a_default = AttributeKey "default"

a_dir :: AttributeKey
a_dir = AttributeKey "dir"

a_dirname :: AttributeKey
a_dirname = AttributeKey "dirname"

a_download :: AttributeKey
a_download = AttributeKey "download"

a_draggable :: AttributeKey
a_draggable = AttributeKey "draggable"

a_dropzone :: AttributeKey
a_dropzone = AttributeKey "dropzone"

a_enctype :: AttributeKey
a_enctype = AttributeKey "enctype"

a_for :: AttributeKey
a_for = AttributeKey "for"

a_form :: AttributeKey
a_form = AttributeKey "form"

a_formaction :: AttributeKey
a_formaction = AttributeKey "formaction"

a_headers :: AttributeKey
a_headers = AttributeKey "headers"

a_height :: AttributeKey
a_height = AttributeKey "height"

a_high :: AttributeKey
a_high = AttributeKey "high"

a_href :: AttributeKey
a_href = AttributeKey "href"

a_hreflang :: AttributeKey
a_hreflang = AttributeKey "hreflang"

a_http_http :: AttributeKey
a_http_http = AttributeKey "http-equiv"

a_icon :: AttributeKey
a_icon = AttributeKey "icon"

a_id :: AttributeKey
a_id = AttributeKey "id"

a_itemprop :: AttributeKey
a_itemprop = AttributeKey "itemprop"

a_keytype :: AttributeKey
a_keytype = AttributeKey "keytype"

a_kind :: AttributeKey
a_kind = AttributeKey "kind"

a_label :: AttributeKey
a_label = AttributeKey "label"

a_lang :: AttributeKey
a_lang = AttributeKey "lang"

a_language :: AttributeKey
a_language = AttributeKey "language"

a_list :: AttributeKey
a_list = AttributeKey "list"

a_low :: AttributeKey
a_low = AttributeKey "low"

a_manifest :: AttributeKey
a_manifest = AttributeKey "manifest"

a_max :: AttributeKey
a_max = AttributeKey "max"

a_maxlength :: AttributeKey
a_maxlength = AttributeKey "maxlength"

a_media :: AttributeKey
a_media = AttributeKey "media"

a_method :: AttributeKey
a_method = AttributeKey "method"

a_min :: AttributeKey
a_min = AttributeKey "min"

a_name :: AttributeKey
a_name = AttributeKey "name"

a_open :: AttributeKey
a_open = AttributeKey "open"

a_optimum :: AttributeKey
a_optimum = AttributeKey "optimum"

a_pattern :: AttributeKey
a_pattern = AttributeKey "pattern"

a_ping :: AttributeKey
a_ping = AttributeKey "ping"

a_placeholder :: AttributeKey
a_placeholder = AttributeKey "placeholder"

a_poster :: AttributeKey
a_poster = AttributeKey "poster"

a_preload :: AttributeKey
a_preload = AttributeKey "preload"

a_radiogroup :: AttributeKey
a_radiogroup = AttributeKey "radiogroup"

a_rel :: AttributeKey
a_rel = AttributeKey "rel"

a_required :: AttributeKey
a_required = AttributeKey "required"

a_reversed :: AttributeKey
a_reversed = AttributeKey "reversed"

a_rows :: AttributeKey
a_rows = AttributeKey "rows"

a_rowspan :: AttributeKey
a_rowspan = AttributeKey "rowspan"

a_sandbox :: AttributeKey
a_sandbox = AttributeKey "sandbox"

a_scope :: AttributeKey
a_scope = AttributeKey "scope"

a_scoped :: AttributeKey
a_scoped = AttributeKey "scoped"

a_seamless :: AttributeKey
a_seamless = AttributeKey "seamless"

a_shape :: AttributeKey
a_shape = AttributeKey "shape"

a_size :: AttributeKey
a_size = AttributeKey "size"

a_sizes :: AttributeKey
a_sizes = AttributeKey "sizes"

a_span :: AttributeKey
a_span = AttributeKey "span"

a_spellcheck :: AttributeKey
a_spellcheck = AttributeKey "spellcheck"

a_src :: AttributeKey
a_src = AttributeKey "src"

a_srcdoc :: AttributeKey
a_srcdoc = AttributeKey "srcdoc"

a_srclang :: AttributeKey
a_srclang = AttributeKey "srclang"

a_srcset :: AttributeKey
a_srcset = AttributeKey "srcset"

a_start :: AttributeKey
a_start = AttributeKey "start"

a_step :: AttributeKey
a_step = AttributeKey "step"

a_style :: AttributeKey
a_style = AttributeKey "style"

a_summary :: AttributeKey
a_summary = AttributeKey "summary"

a_tabindex :: AttributeKey
a_tabindex = AttributeKey "tabindex"

a_target :: AttributeKey
a_target = AttributeKey "target"

a_title :: AttributeKey
a_title = AttributeKey "title"

a_type :: AttributeKey
a_type = AttributeKey "type"

a_usemap :: AttributeKey
a_usemap = AttributeKey "usemap"

a_value :: AttributeKey
a_value = AttributeKey "value"

a_width :: AttributeKey
a_width = AttributeKey "width"

a_wrap :: AttributeKey
a_wrap = AttributeKey "wrap"

-- Data Attributes --

a_data_ :: String -> AttributeKey
a_data_ key = AttributeKey ("data-" ++ key)

a_data :: AttributeKey
a_data = AttributeKey "data"

-- Boolean Attributes --

a_async :: Attribute
a_async = BooleanAttr { key: "async" }

a_selected :: Attribute
a_selected = BooleanAttr { key: "selected" }

a_autofocus :: Attribute
a_autofocus = BooleanAttr { key: "autofocus" }

a_checked :: Attribute
a_checked = BooleanAttr { key: "checked" }

a_disabled :: Attribute
a_disabled = BooleanAttr { key: "disabled" }

a_multiple :: Attribute
a_multiple = BooleanAttr { key: "multiple" }

a_readonly :: Attribute
a_readonly = BooleanAttr { key: "readonly" }

a_novalidate :: Attribute
a_novalidate = BooleanAttr { key: "novalidate" }

a_autoplay :: Attribute
a_autoplay = BooleanAttr { key: "autoplay" }

a_hidden :: Attribute
a_hidden = BooleanAttr { key: "hidden" }

a_loop :: Attribute
a_loop = BooleanAttr { key: "loop" }

a_defer :: Attribute
a_defer = BooleanAttr { key: "defer" }

a_ismap :: Attribute
a_ismap = BooleanAttr { key: "ismap" }

-- Event Handler Attributes --

a_onabort :: AttributeKey
a_onabort = AttributeKey "onabort"

a_onautocomplete :: AttributeKey
a_onautocomplete = AttributeKey "onautocomplete"

a_onautocompleteerror :: AttributeKey
a_onautocompleteerror = AttributeKey "onautocompleteerror"

a_onblur :: AttributeKey
a_onblur = AttributeKey "onblur"

a_oncancel :: AttributeKey
a_oncancel = AttributeKey "oncancel"

a_oncanp :: AttributeKey
a_oncanp = AttributeKey "oncanp"

a_oncanplaythrough :: AttributeKey
a_oncanplaythrough = AttributeKey "oncanplaythrough"

a_onchange :: AttributeKey
a_onchange = AttributeKey "onchange"

a_onclick :: AttributeKey
a_onclick = AttributeKey "onclick"

a_onclose :: AttributeKey
a_onclose = AttributeKey "onclose"

a_oncontextmenu :: AttributeKey
a_oncontextmenu = AttributeKey "oncontextmenu"

a_oncuechange :: AttributeKey
a_oncuechange = AttributeKey "oncuechange"

a_ondblclick :: AttributeKey
a_ondblclick = AttributeKey "ondblclick"

a_ondrag :: AttributeKey
a_ondrag = AttributeKey "ondrag"

a_ondragend :: AttributeKey
a_ondragend = AttributeKey "ondragend"

a_ondragenter :: AttributeKey
a_ondragenter = AttributeKey "ondragenter"

a_ondragexit :: AttributeKey
a_ondragexit = AttributeKey "ondragexit"

a_ondragleave :: AttributeKey
a_ondragleave = AttributeKey "ondragleave"

a_ondragover :: AttributeKey
a_ondragover = AttributeKey "ondragover"

a_ondragstart :: AttributeKey
a_ondragstart = AttributeKey "ondragstart"

a_ondrop :: AttributeKey
a_ondrop = AttributeKey "ondrop"

a_ondurationchange :: AttributeKey
a_ondurationchange = AttributeKey "ondurationchange"

a_onemptied :: AttributeKey
a_onemptied = AttributeKey "onemptied"

a_onended :: AttributeKey
a_onended = AttributeKey "onended"

a_onerror :: AttributeKey
a_onerror = AttributeKey "onerror"

a_onfocus :: AttributeKey
a_onfocus = AttributeKey "onfocus"

a_oninput :: AttributeKey
a_oninput = AttributeKey "oninput"

a_oninvalid :: AttributeKey
a_oninvalid = AttributeKey "oninvalid"

a_onkeydown :: AttributeKey
a_onkeydown = AttributeKey "onkeydown"

a_onkeypress :: AttributeKey
a_onkeypress = AttributeKey "onkeypress"

a_onkeyup :: AttributeKey
a_onkeyup = AttributeKey "onkeyup"

a_onload :: AttributeKey
a_onload = AttributeKey "onload"

a_onloadeddata :: AttributeKey
a_onloadeddata = AttributeKey "onloadeddata"

a_onloadedmetadata :: AttributeKey
a_onloadedmetadata = AttributeKey "onloadedmetadata"

a_onloadstart :: AttributeKey
a_onloadstart = AttributeKey "onloadstart"

a_onmousedown :: AttributeKey
a_onmousedown = AttributeKey "onmousedown"

a_onmouseenter :: AttributeKey
a_onmouseenter = AttributeKey "onmouseenter"

a_onmouseleave :: AttributeKey
a_onmouseleave = AttributeKey "onmouseleave"

a_onmousemove :: AttributeKey
a_onmousemove = AttributeKey "onmousemove"

a_onmouseout :: AttributeKey
a_onmouseout = AttributeKey "onmouseout"

a_onmouseover :: AttributeKey
a_onmouseover = AttributeKey "onmouseover"

a_onmouseup :: AttributeKey
a_onmouseup = AttributeKey "onmouseup"

a_onmousewheel :: AttributeKey
a_onmousewheel = AttributeKey "onmousewheel"

a_onpause :: AttributeKey
a_onpause = AttributeKey "onpause"

a_onplay :: AttributeKey
a_onplay = AttributeKey "onplay"

a_onplaying :: AttributeKey
a_onplaying = AttributeKey "onplaying"

a_onprogress :: AttributeKey
a_onprogress = AttributeKey "onprogress"

a_onratechange :: AttributeKey
a_onratechange = AttributeKey "onratechange"

a_onreset :: AttributeKey
a_onreset = AttributeKey "onreset"

a_onresize :: AttributeKey
a_onresize = AttributeKey "onresize"

a_onscroll :: AttributeKey
a_onscroll = AttributeKey "onscroll"

a_onseeked :: AttributeKey
a_onseeked = AttributeKey "onseeked"

a_onseeking :: AttributeKey
a_onseeking = AttributeKey "onseeking"

a_onselect :: AttributeKey
a_onselect = AttributeKey "onselect"

a_onshow :: AttributeKey
a_onshow = AttributeKey "onshow"

a_onsort :: AttributeKey
a_onsort = AttributeKey "onsort"

a_onstalled :: AttributeKey
a_onstalled = AttributeKey "onstalled"

a_onsubmit :: AttributeKey
a_onsubmit = AttributeKey "onsubmit"

a_onsuspend :: AttributeKey
a_onsuspend = AttributeKey "onsuspend"

a_ontimeupdate :: AttributeKey
a_ontimeupdate = AttributeKey "ontimeupdate"

a_ontoggle :: AttributeKey
a_ontoggle = AttributeKey "ontoggle"

a_onvolumechange :: AttributeKey
a_onvolumechange = AttributeKey "onvolumechange"

a_onwaiting :: AttributeKey
a_onwaiting = AttributeKey "onwaiting"
