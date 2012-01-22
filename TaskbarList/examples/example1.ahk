/*
Example: Demonstrates the usage of *TaskbarList.ahk*
	* Hiding and showing taskbar entries

Authors:
	- maul.esel (https://github.com/maul-esel)

License:
	- *LGPL* (http://www.gnu.org/licenses/lgpl-2.1.txt)

Requirements:
	AutoHotkey - AHK_L v1.1+
	OS - Windows 2000 Professional, Windows XP, Windows 2000 Server or higher
	Classes - CCF (see #include directives for more details)
*/
#SingleInstance force
#include ..\..\_CCF_Error_Handler_\_CCF_Error_Handler_.ahk
#Include ..\..\Unknown\Unknown.ahk
#Include ..\TaskbarList.ahk

tbl := new TaskbarList ; creating the instance
tbl.HrInit() ; initializing the instance

Gui +LastFound
hWin := WinExist() ; get the window handle

Gui Show, w250 h100 ; show the window

sleep 2000
Tooltip The taskbar entry will disappear now.
tbl.DeleteTab(hWin) ; remove the GUI's taskbar entry

sleep 2000
Tooltip The taskbar entry will reappear now.
tbl.AddTab(hWin) ; add the GUI's taskbar entry

sleep 2000

Tooltip The same works for other windows.
WinGet, id, list,,, Program Manager ; get a list of all windows

Loop %id%
    tbl.DeleteTab(id%A_Index%) ; remove all windows' taskbar entries

sleep 3000
Loop %id%
    tbl.AddTab(id%A_Index%) ; add all windows' taskbar entries

Tooltip Done
sleep 3000

GuiClose:
ExitApp
