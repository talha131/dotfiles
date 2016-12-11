; # is Win key
; So
; #a::
; is same as
; LWin & a::
; Using LWin is better because it leaves RWin to be used in default Windows shortcuts
; So
; LWin & a::
; is for select all
; RWin & a::
; is for Windows Action Center

; Win + Tab behave as Alt Tab
LWin & Tab:: AltTab

LWin & a::
send, {ctrl down}a{ctrl up}
Return

LWin & c::
send, {ctrl down}c{ctrl up}
Return

LWin & f::
send, {ctrl down}f{ctrl up}
Return

LWin & t::
send, {ctrl down}t{ctrl up}
Return

LWin & v::
send, {ctrl down}v{ctrl up}
Return

LWin & w::
send, {ctrl down}w{ctrl up}
Return

LWin & x::
send, {ctrl down}x{ctrl up}
Return

LWin & z::
send, {ctrl down}z{ctrl up}
Return

; Use Win + ` to switch between windows of same applications
LWin & `::
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
; WinSet, Top is important. Without it, script does not work for
; applications that have only one window active. The window stays at bottom
WinSet, Top,, ahk_class %ActiveClass%
WinActivate, ahk_class %ActiveClass%
Return

