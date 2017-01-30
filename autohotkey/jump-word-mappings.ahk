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
