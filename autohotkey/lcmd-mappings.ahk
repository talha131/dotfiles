; Use Sharp Keys to map left Cmd to Right Control

; Use Left Cmd + ` to switch between windows of same applications
RControl & `::
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
; WinSet, Top is important. Without it, script does not work for
; applications that have only one window active. The window stays at bottom
WinSet, Top,, ahk_class %ActiveClass%
WinActivate, ahk_class %ActiveClass%
Return

; Use Left Cmd + tab as AltTab
RControl & Tab:: AltTab
