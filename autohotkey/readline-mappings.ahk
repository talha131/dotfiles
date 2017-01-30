#IfWinNotActive, ahk_class Vim
; For Vim use tpope/vim-rsi plugin.
; Vim uses Ctrl+W to switch between windows. 
; That's why we need to exclude Vim from this mapping

LControl & a::
Send {Home}
Return

LControl & e::
Send {End}
Return

; ^ Control
; + Shift

LControl & w::
Send ^+{Left}{BackSpace}
Return

LControl & k::
Send +{End}{Delete}
Return

LAlt & d::
Send ^+{Right}{Delete}
Return

#IfWinNotActive
