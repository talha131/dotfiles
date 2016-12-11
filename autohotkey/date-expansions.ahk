; See explanation of Hotstring here
; https://autohotkey.com/docs/commands/_Hotstring.htm
; `t is tab key
#Hotstring EndChars `t

::dd-::
FormatTime, CurrentDateTime,, yyyy-MM-dd
SendInput %CurrentDateTime%
Return

::dd::
FormatTime, CurrentDateTime,, yyyyMMdd
SendInput %CurrentDateTime%
Return

::ddt-::
FormatTime, CurrentDateTime,, yyyy-MM-dd-HHmm
SendInput %CurrentDateTime%
Return

::ddt::
FormatTime, CurrentDateTime,, yyyyMMddHHmm
SendInput %CurrentDateTime%
Return

