#SingleInstance force
Menu, tray, NoStandard
Menu, tray, add, Config
Menu, tray, Default, Config
Menu, tray, add, Rosh, Rosh
Menu, tray, add
Menu, tray, add, Open cfg folder, autoexec.cfg
Menu, tray, add, Exit
;Menu, Tray, Icon, %A_ScriptDir%\%A_ScriptName%,1,1

Version=v1.2

IniRead, accepter, %A_MyDocuments%\d2a.ini, Config, Accepter, F11

IniRead, PosX, %A_MyDocuments%\d2a.ini, Config, Custom PosX, %A_Space%
IniRead, PosY, %A_MyDocuments%\d2a.ini, Config, Custom PosY, %A_Space%
IniRead, AcceptMethod, %A_MyDocuments%\d2a.ini, Config, AcceptMethod, 1

if (AcceptMethod==1){
AcceptMethod1:=1
AcceptMethod2:=0
}else {
AcceptMethod1:=0
AcceptMethod2:=1
}


RegRead, SteamPath, HKEY_CURRENT_USER, Software\Valve\Steam, SteamPath

Hotkey,%accepter%, accept
return

accept:
gojoin:=!gojoin
if gojoin
{
if (!PosX){
x:=A_ScreenWidth*.5
} else {
x:=PosX
}
if (!PosY){
y:=A_ScreenHeight*.4907
} else {
y:=PosY
}

gosub, Accepter
sleep 100
SetTimer, Accepter, 2012
}
else
{
ToolTip
SetTimer, Accepter, off
}
return

Accepter:
ifWinActive,Dota 2
{

ToolTip, Dota2 Accepter is active`nPress %accepter% to deactivate
if (AcceptMethod==1){
send {vk0D}
}else {
MouseMove,x,y
sleep,1
Click
}
}
return

Config:
Gui, Destroy
gui, font, s10 w500

Gui, Add, Hotkey, vaccepter x5 y5 w50 h20 , %accepter%
Gui, Add, Text, x60 y5, to activate/deactivate Dota2 Accepter

Gui, Add, Edit, vNewPosX x5 y55 w50 h20 , %PosX%
Gui, Add, Text, x60 y55, Position X*
Gui, Add, Edit, vNewPosY x5 y80 w50 h20 , %PosY%
Gui, Add, Text, x60 y80, Position Y*
Gui, Add, Text, x5 y100, *Position in pixels where to click. Leave blank for default. Used for clicker method.

Gui, Add, Text, x5 y140, Every 2 seconds produce:
Gui, Add, Radio, x5 y160 altsubmit vAcceptMethod Checked%AcceptMethod1%, Enter Press
Gui, Add, Radio, x5 y180 altsubmit Checked%AcceptMethod2%, Mouse Click

Gui, Add, Button, gsaveconfig x3 y230 w354 h30,Save

Gui, Show, w360 h260,Dota2 Accepter Config
return



saveconfig:
gui, submit
IniWrite,%accepter%, %A_MyDocuments%\d2a.ini, Config, Accepter
IniWrite,%NewPosX%, %A_MyDocuments%\d2a.ini, Config, Custom PosX
IniWrite,%NewPosY%, %A_MyDocuments%\d2a.ini, Config, Custom PosY
IniWrite,%AcceptMethod%, %A_MyDocuments%\d2a.ini, Config, AcceptMethod
reload
return

GuiEscape:
GuiClose:
gui, destroy
return

Exit:
ExitApp
return

Rosh:
MsgBox 64, Rosh Notifier, Alt+click the clock in game!`nRosh respawns after a random time between 8-11 minutes`nAegis is removed after 5 minutes
return

autoexec.cfg:
;FileAppend, , %SteamPath%\steamapps\common\dota 2 beta\game\dota\cfg\autoexec.cfg
;Run, Notepad.exe %SteamPath%\steamapps\common\dota 2 beta\game\dota\cfg\autoexec.cfg
Run, Explore %SteamPath%/steamapps/common/dota 2 beta/game/dota/cfg
return
