; Windows use Ctrl key for jumping between words. I am used to Alt key

LAlt & Left::
If GetKeyState("Shift", "p")
    Send ^+{Left}
else
    Send ^{Left}
Return

LAlt & Right::
If GetKeyState("Shift", "p")
    Send ^+{Right}
else
    Send ^{Right}
Return
