; Using SharpKeys, I map Left Windows key to Left Control key
; So LControl in the following script is actually Left Windows key

; Make Ctrl + Tab, behave as Alt + Tab
LControl & Tab:: AltTab

; Use Ctrl + ` to switch between windows of same applications
LControl & `::
WinGetClass, ActiveClass, A
WinSet, Bottom,, A
; WinSet, Top is important. Without it, script does not work for
; applications that have only one window active. The window stays at bottom
WinSet, Top,, ahk_class %ActiveClass%
WinActivate, ahk_class %ActiveClass%
return
