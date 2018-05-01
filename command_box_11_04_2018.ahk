SetTitleMatchMode, 2
SetFormat, float, 0.1
;SetKeyDelay, 0
; Last Updated 04/08/2016
; Included an OCR relationships scan to SCANAIT command.
; Last UPDATED 02/08/2016
; Updated SCANAIT gui, and included a USED BY relationships scan
; Last UPDATED 06/07/2016
; Added script to open graphics in windows from AIT.
; LAST UPDATED 17/06/2016
; Added script to open graphics in ait from a windows file
; LAST UPDATED 28/04/2016 v1.6
; Updated file locations for new PC
; LAST UPDATED 16/03/2016 v1.5
; Added commands to load powermill based off its version number from local or network.
; Added command to list most recent powermill versions

;-------------------------------------------------------
; GUIs
;{------------------------------------------------------

; GUI 1
;~~~~~~~~~~~~~~~
Gui, +AlwaysOnTop -SysMenu +Owner 
Gui, Add, Edit, vSearchParam gBarnesCommand

; Send text GUI
;~~~~~~~~~~~~~~~

Gui, 2:+AlwaysOnTop -SysMenu +Owner
Gui, 2:Add, Edit, -WantReturn vSearchEdit
; add a hidden button that captures the Enter key:
Gui, 2:Add, Button, x-10 y-10 w1 h1 +default gSearchEditEnter

; Run URL GUI
;~~~~~~~~~~~~~~~
Gui, 3:+AlwaysOnTop -SysMenu +Owner
Gui, 3:Add, Edit, -WantReturn vSearchEdit
; add a hidden button that captures the Enter key:
Gui, 3:Add, Button, x-10 y-10 w1 h1 +default gWebSearch

; Search Spotify GUI
;~~~~~~~~~~~~~~~~~~~
Gui, 4:+AlwaysOnTop -SysMenu +Owner
Gui, 4:Add, Edit, -WantReturn vSearchEdit
; add a hidden button that captures the Enter key:
Gui, 4:Add, Button, x-10 y-10 w1 h1 +default gSpotify

; CHM to AIT GUI
;~~~~~~~~~~~~~~~~~~~
Gui, 5:+AlwaysOnTop -SysMenu +Owner 
Gui, 5:Add, Radio, h15  Checked vRadioButton1, CHM > AIT (Graphic)
Gui, 5:Add, Radio, h15 , CHM > AIT (Topic)
Gui, 5:Add, Radio, h15 y+20, File > AIT + Snag (Graphic)
Gui, 5:Add, Radio, h15 , File > Clipboard (Graphic)
Gui, 5:Add, Radio, h15 y+20, CHM > Clipboard (Graphic)
Gui, 5:Add, Radio, h15 , CHM > Clipboard (Topic)
Gui, 5:Add, Radio, h15 y+20, AIT > File (Graphic)
Gui, 5:Add, Radio, h15 y+20, RIBBON FIND TOPIC
Gui, 5:Add, Radio, h15 y+10, Copy Alias Name
Gui, 5:Add, Button, x-10 y-10 w1 h1 Default gchmdata, OK


; Graph display GUI
;~~~~~~~~~~~~~~~~~~~~
Gui, 7: Add, Picture, vMyPic , C:\Users\Public\pic2.bmp
Gui, 7: Add, Button, gRefreshPic +Default Y300 X+100, Refresh
Gui, 7: Add, Button, gBrLoop X+50, Stop
Gui, 7: Add, Button, gPauseLoop X+50, Pause

; Number of graph values GUI
;~~~~~~~~~~~~~~~~~~~~
Gui, 8: +AlwaysOnTop ToolWindow
Gui, 8: Add, Text,, Number of X values 
Gui, 8: Add, Edit
Gui, 8: Add, UpDown, vNoXvalues Range0-1000,
Gui, 8: Add, Text,, Number of Y values
Gui, 8: Add, Edit
Gui, 8: Add, UpDown, vNoYvalues Range0-1000,
Gui, 8: Add, Button, X150 Y45 gSubmitValues, OK
Gui, 8: Add, GroupBox, h1 w200 Y100 X0
Gui, 8: Add, Button, X135 Y150 +default gRealTime, Realtime
Gui, 8: Add, GroupBox, Section h100 w100 X10 Y110, Options
Gui, 8: Add, Radio, vIncreasingX xs+10 ys+20, Autofill X
Gui, 8: Add, Radio, vXandY xs+10 ys+40, X and Y
Gui, 8: Add, Radio, vRandY xs+10 ys+60, Random
Gui, 8: Add, Radio, vCosX xs+10 ys+80, CosX

; Click to create graph GUI
;~~~~~~~~~~~~~~~~~~~~
Gui, 9: +AlwaysOnTop ToolWindow
Gui, 9: Add, Text,, Click OK to create your graph.
Gui, 9: Add, Button, +default gGraphcreate, OK

; AIT scan loop
;~~~~~~~~~~~~~~~~~~~
Gui, 10: +AlwaysOnTop ToolWindow
Gui, 10: Add, Text, cBlue, If you are starting a new scan please delete content in: `n C:\Users\Public\Names Scan.txt `n C:\Users\Public\[Using] Relationships Scan.txt `n C:\Users\Public\[Used by] Relationships Scan.txt `n C:\Users\Public\[Using] OCR Template Scan.txt
Gui, 10: Add, Text,, Enter the number of objects to loop over 
Gui, 10: Add, Edit
Gui, 10: Add, UpDown, vAITscan Range0-10000,0
Gui, 10: Add, Button, X220 Y170 +default gAITScanButton, Go
Gui, 10: Add, GroupBox, Section h120 w200 X10 Y130, Cycle type
Gui, 10: Add, Radio, vNameScan xs+10 ys+20, Graphics Name Scan
Gui, 10: Add, Radio, vUsingScan xs+10 ys+40, [Using] Relationships Scan
Gui, 10: Add, Radio, vUsedByScan xs+10 ys+60, [Used By] Relationships Scan
Gui, 10: Add, Radio, vUsingOCRScan xs+10 ys+80, [Using] OCR Template Scan
Gui, 10: Add, Radio, vUsedByOCRScan xs+10 ys+100, [Used By] OCR (EB > EB)
Gui, 10: Add, GroupBox, Section h150 w120 X340 Y5, Loop Counter
Gui, 10: Add, Button, gShowLoopGui Y20 X345, Show loop counter
Gui, 10: Add, Button, gHideLoopGui Y+10, Hide loop counter
Gui, 10: Add, Button, gRefreshLoopGui Y+10, Refresh loop counter

; AIT scan loop counter
;~~~~~~~~~~~~~~~~~~~~
Gui, 11: Color, FFFFFF +AlwaysOnTop
Gui, 11: Add, Text, r2 w35  vMyText +border
Gui, 11: Add, Text, r10 w300 vOCRText +border
Gui, 11: Add, Text, x325 y30 w200 vProgressText, Scan not started.
Gui, 11: Add, Text, x60 y12 vObjectText w300,
Gui, 11: Add, Progress, x325 y46 w200 cBlue h45 vMyProgress +Smooth
Gui, 11: Add, Progress, x325 y103 w200 cLime h72 vMyTotalProgress Range0-%AITscan% +Smooth
Gui, 11: Add, Text, x325 y132 w200 +Center +BackgroundTrans vPercentText, 0`%
;}

;-------------------------------------------------------
; HOTKEYS
;{------------------------------------------------------

#c::
Gui, Show ,, ƒ(x)
return

+esc::
BreakLoop = 1
MsgBox,,Scan interrupt, Scan interrupted after %loopcounter% cycles.
reload
return

;}

;-------------------------------------------------------
; COMMAND BOX LABEL
;{------------------------------------------------------

; BarnesCommand tries to match whatever is in the input box with your SEARCH PARAMETERS:
BarnesCommand:
Gui, Submit, NoHide

;}

;-------------------------------------------------------
; SEARCH PARAMETERS
;{------------------------------------------------------

	; this reloads this script. Useful after changing something in the script.
	if SearchParam = reload
	{
	  Reload
	  Sleep 200
	  MsgBox, Something went wrong
	}
	
	if SearchParam = topicid,,
	{
		Gosub, resetGUI
		Gui 5:Show,, Clipboard
	}
	
	if SearchParam = graphic
	{
		Gosub, resetGUI
		Gui 5:Show,, Clipboard
	}
	
	if SearchParam = find%A_Space%graphic
	{
		Gosub,resetGUI
		Gui, 5:Show,, CHM > AIT
	}
	
	if SearchParam = open%A_Space%topic
	{
		Gosub,resetGUI
		Gui, 5:Show,, CHM > AIT
	}
	
	if SearchParam = dialog%A_Space%
	{
		Gosub,resetGUI
		Gui, 2:Show,, Dialog Name?
		oldSTRING = The {Ctrl Down}{b}{Ctrl Up}REPLACEME{Space}{Shift Down}{Left}{Shift Up}{Ctrl Down}{Space}{Right}{Ctrl Up}dialog is displayed.	
	}
	
	if SearchParam = g%A_Space%
	{
		Gosub,resetGUI
		Gui, 3:Show,, Google
		oldURL = https://www.google.com/search?num=50&safe=off&site=&source=hp&q=REPLACEME&btnG=Search&oq=&gs_l=
	}
	
	if SearchParam = twitch%A_Space%
	{
		Gosub,resetGUI
		Gui, 3:Show,, Twitch.tv
		oldURL = http://www.twitch.tv/directory/game/REPLACEME
	}
	
	if SearchParam = mail
	{
		Gosub, resetGUI
		WinShow ahk_class rctrl_renwnd32
		WinActivate ahk_class rctrl_renwnd32
	}
	
	if SearchParam = outlook
	{
		Gosub, resetGUI
		Run C:\Program Files\Microsoft Office 15\root\office15\OUTLOOK.EXE
	}
	
	if SearchParam = excel
	{
		Gosub, resetGUI
		IfWinExist, Microsoft Excel
		{
		WinShow Microsoft Excel
		WinActivate Microsoft Excel
		}
		else
		{
		Run C:\Program Files\Microsoft Office 15\root\office15\EXCEL.EXE
		}
	}
	
	if SearchParam = word
	{
		Gosub, resetGUI
		IfWinExist, ahk_class OpusApp
		{
		WinShow ahk_class OpusApp
		WinActivate ahk_class OpusApp
		}
		else
		{
		Run C:\Program Files\Microsoft Office 15\root\office15\WINWORD.EXE
		}
	}
	
	if SearchParam = psteam
	{
		Gosub, resetGUI
		IfWinExist, ahk_class IEFrame
		{
			WinShow, ahk_class IEFrame
			WinActivate, ahk_class IEFrame
			Sleep, 250
			Send, ^t
			Sleep, 250
			Send, http://psteam.delcam.com/{Enter}
		}
		else
		{
			Run, Iexplore.exe
			Sleep, 250
			WinShow, Internet Explorer
			WinActivate, Internet Explorer
			Sleep, 250
			Send, ^l
			Send, http://psteam.delcam.com/{Enter}
		}
	}
	
	if SearchParam = baloo
	{
		Gosub, resetGUI
		IfWinExist, ahk_class IEFrame
		{
			WinShow, ahk_class IEFrame
			WinActivate, ahk_class IEFrame
			Sleep, 250
			Send, ^t
			Sleep, 250
			Send, http://baloo/{Enter}
		}
		else
		{
			Run, Iexplore.exe
			Sleep, 250
			WinShow, Internet Explorer
			WinActivate, Internet Explorer
			Sleep, 250
			Send, ^l
			Send, http://baloo/{Enter}
		}
	}
	
	if SearchParam = gmail
	{
		Gosub, resetGUI
		Run, https://mail.google.com/mail/u/0/#inbox
	}
	
	if SearchParam = jira
	{
		Gosub, resetGUI
		Run, https://jira.autodesk.com/secure/RapidBoard.jspa?projectKey=DELCXD&rapidView=5526&view=planning
	}
	
	if SearchParam = sharepoint
	{
		Gosub, resetGUI
		Run, https://share.autodesk.com/sites/TeamSite/Papyrus`%20(CXD)/SitePages/Home.aspx?e=1`%3A2871084dbc4942758e2f0c9ae8628f4d
	}
	
	if SearchParam = wiki
	{
		Gosub, resetGUI
		Run, https://wiki.autodesk.com/pages/viewpage.action?pageId=270353287
	}
	
	if SearchParam = spot%A_Space%
	{
		Gosub, resetGUI
		Gui, 4:Show,, Spotify
		oldSTRING = REPLACEME{Enter}
	}
	
	if SearchParam = note
	{
		Gosub, resetGUI
		Run C:\Program Files (x86)\Notepad++\notepad++.exe
	}
	
	if SearchParam = pshelp
	{
		Gosub, resetGUI
		IfWinExist, PowerSHAPE reference help
		{
			WinShow PowerSHAPE reference help
			WinActivate PowerSHAPE reference help
		}
		else
		{
			;Run \\ns6.delcam.local\doc-Released\PowerSHAPE\2017\RH\Help.chm
			Run C:\Users\Barnesc\Desktop\pshelp.chm
		}
	}
	
	if SearchParam = pmhelp
	{
		Gosub, resetGUI
		Run, https://help.autodesk.com/view/PWRM/2019/ENU/
	}
	
	if SearchParam = pmstag
	{
		Gosub, resetGUI
		Run, https://help-staging.autodesk.com/view/PWRM/2019/ENU/
	}
	
	if SearchParam = fcamhelp
	{
		Gosub, resetGUI
		Run, https://help.autodesk.com/view/FCAM/2019/ENU/
	}
	
	if SearchParam = fcamstag
	{
		Gosub, resetGUI
		Run, https://help-staging.autodesk.com/view/FCAM/2019/ENU/
	}
	
	if SearchParam = skype
	{
		Gosub, resetGUI
		IfWinExist, Skype
		{
			WinShow Skype
			WinActivate Skype
		}
		else
		{
			Run C:\Program Files (x86)\Skype\Phone\Skype.exe
		}
	}
	
	if SearchParam = ait
	{
		Gosub, resetGUI
		IfWinExist, Author-it 5
		{
			WinShow Author-it 5
			WinActivate Author-it 5
		}
		else
		{
			Run C:\Program Files (x86)\Author-it 5\Authorit5.exe
		}
	}
	
	if SearchParam = websdl
	{
		Gosub, resetGUI
		Run, https://trisoftcms.autodesk.com/ISHCM
	}
	
	
	if SearchParam = sdl
	{
		Gosub, resetGUI
		IfWinExist, SDL LiveContent Architect Publication Manager
		{
			WinShow SDL LiveContent Architect Publication Manager 
			WinActivate SDL LiveContent Architect Publication Manager 
		}
		else
		{
			Run C:\Program Files (x86)\SDL\Publication Manager\12.0\Trisoft.PublicationManager.Host.exe
		}
	}
	
	if SearchParam = xmetal
	{
		Gosub, resetGUI
		IfWinExist, XMetaL Author Enterprise
		{
			WinShow XMetaL Author Enterprise 
			WinActivate XMetaL Author Enterprise 
		}
		else
		{
			Run C:\Program Files (x86)\XMetaL 11.0\Author\xmetal.exe
		}
	}
	
	if SearchParam = snagit
	{
		Gosub, resetGUI
		IfWinExist, ahk_class SnagIt9Editor
		{
			WinShow ahk_class SnagIt9Editor
			WinActivate ahk_class SnagIt9Editor
		}
		else
		{
			Run C:\Program Files (x86)\TechSmith\Snagit 12\SnagitEditor.exe
		}
	}
	
	if SearchParam = -
	{
		Gosub, resetGUI
		Send, —		
	}
	
	if SearchParam = b%A_Space%
	{
		Gosub, resetGUI
		Gui, 2:Show,, Bold
		oldSTRING = {Ctrl Down}{b}{Ctrl Up}REPLACEME{Space}{Shift Down}{Left}{Shift Up}{Ctrl Down}{Space}{Right}{Ctrl Up}
	}
	
	if SearchParam = bb%A_Space%
	{
		Gosub, resetGUI
		Gui, 2:Show,, Bold
		oldSTRING = {Ctrl Down}{b}{Ctrl Up}REPLACEME{Space}{Shift Down}{Left}{Shift Up}{Ctrl Down}{Space}{Right}{Ctrl Up}{—}{Space}{Enter}
	}
	
	if SearchParam = calc
	{
		Gosub, resetGUI
		Run, calc
	}
	
	if SearchParam = delcam%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,,\\Delcam\Doc\
		oldURL = \\delcam\doc\REPLACEME\
	}
	
	if SearchParam = ns3%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,,\\NS3\
		oldURL = \\NS3.delcam.local\REPLACEME\
	}
	
	if SearchParam = central%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,, Central Transfer
		oldURL = \\ns8.delcam.local\transfer\REPLACEME\
	}
	
	if SearchParam = exp%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,, Explorer
		oldURL = REPLACEME
	}
	
	if SearchParam = dir%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,, Explorer
		oldURL = REPLACEME
	}
	
	if SearchParam = pmillold
	{
		Gosub, resetGUI
		IfWinExist, PowerMILL Pro 2016
		{
			WinShow PowerMILL Pro 2016
			WinActivate PowerMILL Pro 2016
		}
		else
		{
			Run D:\Program Files\Delcam\PowerMILL\PowerMILL 20.0.10\sys\exec64\pmill.exe
			;remember to update file path with new version of powermill
		}
	}
	
	if SearchParam = pmlocal
	{
		Gosub, resetGUI
		Loop D:\Program Files\Delcam\PowerMILL\*.*, 2, 0
		{
		MostRecent := (A_Index = 1 ? A_LoopFileFullPath : MostRecent)
		FileGetTime MostRecentTime, %MostRecent%, C
		MostRecent := (A_LoopFileTimeModified > MostRecentTime ? A_LoopFileFullPath : MostRecent)
		}
		Fpath=%MostRecent%\sys\exec64\pmill.exe
		Run, %Fpath%
		MsgBox, ,%MostRecent%, Running %MostRecent%., 3
		Return
	}
	
	if SearchParam = pmnet
	{
		Gosub, resetGUI
		SetWorkingDir, \\dmk3.delcam.local\dcam\
		files =
		ArrayCount = 0
		Loop %A_WorkingDir%\*, 2
		{
			ArrayCount +=1
			files%ArrayCount% := A_LoopFileName
		}
		MostRecent := files%ArrayCount%
		SetWorkingDir, C:\Users\cjb\Desktop\Fun Junk\command box\safe dir
				;Loop \\dmk3.delcam.local\dcam\*.*, 2, 0
				;{
				;MostRecent := (A_Index = 1 ? A_LoopFileFullPath : MostRecent)
				;FileGetTime MostRecentTime, %MostRecent%, C
				;MostRecent := (A_LoopFileTimeModified > MostRecentTime ? A_LoopFileFullPath : MostRecent)
				;}
		Fpath=\\dmk3.delcam.local\dcam\%MostRecent%\sys\exec64\pmill.exe
				;Fpath=%MostRecent%\sys\exec64.pmill.exe
		Run, %Fpath%
		MsgBox, ,%MostRecent%, Running %MostRecent%., 3
		Return
	}
	
	if SearchParam = guid
	{
		Gosub, resetGUI
		IfWinActive, ahk_exe Trisoft.PublicationManager.Host.exe
		{
			Send, {AppsKey}
			Send, W
			Send, {Enter}
			WinWait, Open with
			Send, P
			Send, {Enter}
			WinWaitActive, ahk_exe mspaint.exe,, 10
			if ErrorLevel
			{
			MsgBox, WinWait timed out
			reload
			}
			else
			{
			Sleep, 100
			IfWinActive, ahk_exe mspaint.exe
			{
				WinGetActiveTitle, painttitle
				StringSplit, GUIDVAR, painttitle, =
				StringSplit, FinalGUID, GUIDVAR2, =
				clipboard = %FinalGUID1%
				ToolTip, %FinalGUID1%,,,
					SetTimer, RemoveToolTip, 2000
				WinClose, %painttitle%
			}
			return
		}
		}
		else
		{
			reload
			return
		}
	}
	
	if SearchParam = pmillrib
	{
		Gosub, resetGUI
		Gui, 3:Show,,PowerMILL version
		oldURL = D:\Program Files\Delcam\PowerMILL\powermillREPLACEME\sys\exec64\pmill-ribbon.exe
	}
	
	if SearchParam = pmill%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,,PowerMILL version
		oldURL = D:\Program Files\Delcam\PowerMILL\powermillREPLACEME\sys\exec64\pmill.exe
	}
	
	if SearchParam = pmillnet%A_Space%
	{
		Gosub, resetGUI
		Gui, 3:Show,,PowerMILL version
		oldURL = \\dmk3.delcam.local\dcam\powermillREPLACEME\sys\exec64\pmill.exe
	}
	
	if SearchParam = pshape
	{
		Gosub, resetGUI
		IfWinExist, Delcam PowerSHAPE
		{
			WinShow Delcam PowerSHAPE
			WinActivate Delcam PowerSHAPE
		}
		else
		{
			Run D:\Program Files\Delcam\PowerSHAPE16130\sys\exec64\PowerSHAPE-Pro\DelcamLauncher.exe -pro
			;remember to update file path with new version of powermill
		}
	}
	
	if SearchParam = vs
	{
		Gosub, resetGUI
		IfWinActive, ahk_exe chrome.exe
		{
			Send, {f6}
			Send, {End}
			Send, &view-source
			Send, {Enter}
		}
		else
		{
			Msgbox Make Chrome the active window.
		}
	}
	
	if SearchParam = home
	{
		Gosub, resetGUI
		Send, #d
	}
	; paste the cid to an AKN url
	if SearchParam = cid
	{
		Gosub, resetGUI
		IfWinActive, ahk_exe chrome.exe
		{
			WinGetTitle, ChromeTitle
			Send, {F6}
			Send, ^c
			AknURL := clipboard
			StringSplit, AknURLArray, AknURL, ?
			InputBox, UserInput, ContextId, Please enter the ContextId you want to append to the URL
			WinActivate, %ChromeTitle%
			Sleep,100
			;Send, {f6}
			Sleep, 100
			Send, {Delete}
			Sleep, 200
			Send, %AknUrlArray1%?contextId=%UserInput%
			Send, {Enter}
		}
		else
		{
			Msgbox Make Chrome the active window.
		}
	}
	
	if SearchParam = lock
	{
		Gosub, resetGUI
		DllCall("LockWorkStation")
		Sleep, 200
		SendMessage,0x112,0xF170,2,,Program Manager
	}
	
	if SearchParam = graph
	{
		Gosub, resetGUI
		Gosub, graphscript
	}
	
	if SearchParam = scanait
	{
		Gosub, resetGUI
		Gui, 10: Show,, Scan AIT database
	}
	
	if SearchParam = beep
	{
		Gosub, resetGUI
		SoundBeep, 262, 250
		SoundBeep, 294, 250
		SoundBeep, 330, 250
	}
	
	if SearchParam = al%A_Space%
	{
		Gosub, resetGUI
		Send, Pmill.chm::/%clipboard%.htm //{SPACE}
	}
	
	if SearchParam = pmillversions
	{
	Gosub, resetGUI
	SetWorkingDir, \\dmk3.delcam.local\dcam\
	Msgbox % list_files(A_WorkingDir)
	
	list_files(Directory)
	{
	files =
	shortfiles =
	;ArrayCount = 0
	Loop %A_WorkingDir%\*, 2
		{
		;ArrayCount +=1
		;files%ArrayCount% := A_LoopFileName
		files = %files%`n%A_LoopFileName%
		}
	StringRight, shortfiles, files, 104
	;return files
	return, shortfiles
	
	return files415
	SetWorkingDir, C:\Users\cjb\Desktop\Fun Junk\command box\safe dir
	}
	}
	
	;To set the template of an object in AIT to inactive
	if SearchParam = zx
	{
		gosub, resetGUI
		Send, {AppsKey}
		sleep, 200
		Send, cc{Enter}zz{Enter}
		Sleep, 200
		Send, {AppsKey}
		Sleep, 200
		Send, L
	}
	
	if SearchParam = zz
	{
		gosub, resetGUI
		Send, {AppsKey}
		sleep, 200
		Send, cc{Enter}zz{Enter}	
	}
	; If SearchParam = nn
	;{
	;	GuidArray2 =
	;	clipboard =
	;	gosub, resetGUI
	;	Send, ^c
	;	ClipWait, 5
	;	FirstVar = %clipboard%
	;	StringSplit, FirstVarArray, FirstVar,`/
	;	StringSplit, SecVarArray, FirstVarArray2,`'
	;	WinActivate, Notepad++
	;	Send, ^f
	;	Send, %SecVarArray1%
	;	Send, !o
	;	Sleep, 100
	;	WinGetText, FindResultsVar, Find result
	;	Loop, Parse, FindResultsVar, `r`n
	;	{
;
	;		If (A_Index = 9)
	;		{
	;			IfInString, A_LoopField, C:\Users\Barnesc\Documents\InfoShare
	;			{
	;				CopyVar = %A_LoopField%
	;			}
	;		}
	;		If (A_Index = 15)
	;		{
	;			IfInString, A_LoopField, Line
	;			{
	;				LineVar = %A_LoopField%
	;			}
	;		}
	;	}
	;	StringSplit, GUIDArray, CopyVar, `=
	;	StringSplit, LineArray, LineVar, `:
	;	MsgBox ,,, %LineArray1%`n`n%GUIDArray2%, 1
	;	Clipboard = %GUIDArray2%`#%GUIDArray2%
	;	WinActivate, Notepad++
	;}	
	;Quick mode to search GUIDS from broken conrefs in notepad++
	; If SearchParam = cc
	;{
	;	GuidArray2 =
	;	clipboard =
	;	gosub, resetGUI
	;	Send, ^c
	;	ClipWait, 5
	;	FirstVar = %clipboard%
	;	StringSplit, FirstVarArray, FirstVar,`/
	;	StringSplit, SecVarArray, FirstVarArray2,`'
	;	WinActivate, Notepad++
	;	Send, ^f
	;	Send, %SecVarArray1%
	;	Send, !o
	;	Sleep, 100
	;	WinGetText, FindResultsVar, Find result
	;	Loop, Parse, FindResultsVar, `r`n
	;	{
;
	;		If (A_Index = 9)
	;		{
	;			IfInString, A_LoopField, C:\Users\Barnesc\Documents\InfoShare
	;			{
	;				CopyVar = %A_LoopField%
	;			}
	;		}
	;		If (A_Index = 15)
	;		{
	;			IfInString, A_LoopField, Line
	;			{
	;				LineVar = %A_LoopField%
	;			}
	;		}
	;	}
	;	StringSplit, GUIDArray, CopyVar, `=
	;	StringSplit, LineArray, LineVar, `:
	;	MsgBox ,,, %LineArray1%`n`n%GUIDArray2%, 1
	;	Clipboard = %GUIDArray2%`#%GUIDArray2%
	;	WinActivate, Notepad++
	;}	
	
	if SearchParam = cs ; Quickly adding the PMStrategy code to the Alias name field in an objects properties dialog
	{
		gosub, resetGUI
		IfWinActive, Author-it 5
		{
			Send, {AppsKey}
			sleep, 250
			Send, P
			sleep, 250
			WinGetActiveTitle, PropertiesWin
			ControlClick, x226 y44, %PropertiesWin%
			ControlClick, x140 y256, %PropertiesWin%
			Sleep, 200
			Send, PMStrategy
			;ControlSend, WindowsForms10.EDIT.app.0.33c0d9d8, PMStrategy, %PropertiesWin%
			ControlClick, WindowsForms10.BUTTON.app.0.33c0d9d3, %PropertiesWin%
		}
		else
		{
		}
				
	}
	
	
	if SearchParam = cg ; Quickly adding the PMGeneral code to the Alias name field in an objects properties dialog
	{
		gosub, resetGUI
		IfWinActive, Author-it 5
		{
			Send, {AppsKey}
			sleep, 250
			Send, P
			sleep, 250
			WinGetActiveTitle, PropertiesWin
			ControlClick, x226 y44, %PropertiesWin%
			ControlClick, x140 y256, %PropertiesWin%
			Sleep, 200
			Send, PMGeneral
			;ControlSend, WindowsForms10.EDIT.app.0.33c0d9d8, PMGeneral, %PropertiesWin%
			ControlClick, WindowsForms10.BUTTON.app.0.33c0d9d3, %PropertiesWin%
		}
		else
		{
		}
				
	}
	if SearchParam = mario
	{
		Gosub, resetGUI
		; Section 1
		SoundBeep, 330, 120 ; E4
		SoundBeep, 330, 150 ; E4
		SoundBeep, 330, 250 ; E4
		SoundBeep, 262, 100 ; C4
		SoundBeep, 330, 200 ; E4
		SoundBeep, 392, 500 ; G4
		SoundBeep, 196, 500 ; G3
		; Section 2
		SoundBeep, 262, 375 ; C4
		SoundBeep, 196, 300 ; G3
		SoundBeep, 164, 300 ; E3
		SoundBeep, 196, 300 ; G3
		SoundBeep, 247, 190	; B3
		SoundBeep, 233,	190	; B3flat
		SoundBeep, 220,	190 ; A3
		SoundBeep, 196, 300 ; G3
		; Section 3
		SoundBeep, 329, 150	; E4
		SoundBeep, 392, 175	; G4
		SoundBeep, 440, 200	; A4
		SoundBeep, 350, 190	; F4
		SoundBeep, 392, 190	; G4
		SoundBeep, 330, 190	; E4
		SoundBeep, 262, 150	; C4
		SoundBeep, 294, 190	; D4
		SoundBeep, 247, 190	; B3
		; Section 2
		SoundBeep, 262, 300 ; C4
		SoundBeep, 196, 250 ; G3
		SoundBeep, 164, 200 ; E3
		SoundBeep, 196, 250 ; G3
		SoundBeep, 247		; B3
		SoundBeep, 233		; B3flat
		SoundBeep, 220		; A3
		SoundBeep, 196		; G3
		; Section 3
		SoundBeep, 329		; E4
		SoundBeep, 392		; G4
		SoundBeep, 440		; A4
		SoundBeep, 350		; F4
		SoundBeep, 392		; G4
		SoundBeep, 330		; E4
		SoundBeep, 262		; C4
		SoundBeep, 294		; D4
		SoundBeep, 247		; B3
		; Section 4
		SoundBeep, 392		; G4
		SoundBeep, 370		; F4#
		SoundBeep, 350		; F4
		SoundBeep, 312		; D4#
		SoundBeep, 330		; E4
	}
	
	if SearchParam = dd
	{
		Gosub, resetGUI
		FormatTime, NewTime,, yyyy-MMM-dd
		Send, CJB (%NewTime%):%A_Space%
	}
	; Pastes a CID from the clipboard into XMETAL
	if SearchParam = pastecid
	{
		Gosub, resetGUI
		WinActivate, XMetaL Author Enterprise
		IfWinActive, ahk_exe xmetal.exe
		{
		WinGetActiveTitle, Title
		Send, {Ctrl Down}{Enter}
		Sleep, 200
		Send, {Ctrl Up}
		Sleep, 250
		Send, contextid
		Sleep, 300
		Send,{Enter}
		Sleep, 200
		Send, {Right}{Left}
		Sleep, 200
		ControlFocus, Afx:ControlBar:400000:8:10005:101, %Title%
		Sleep,250
		ControlClick, Button26, %Title%, $$$Panel$$$
		Sleep, 250
		Send, %Clipboard%
		Sleep, 250
		Send, {Enter}
		;Clipboard = 
		SoundBeep, 330, 120
		}
		
		else															; Else do nothing
		{
		Return
		}
		
		Reload
		Return
	}
	
	if SearchParam = help
	{
		Gosub, resetGUI
		MsgBox, 262208, Help,
		( LTrim
Help is coming soon! Please email cjb@delcam.com with your questions.

COMMANDS                                                    Description
-----------------------------------------------------------------------
reload		 — 	Reloads the GUI
topicid		 — 	Copy topic ID to clipboard
graphic		 — 	Copy graphic name to clipboard
open topic	 — 	Opens CHM topic in AIT
find graphic	 — 	Finds graphic in AIT
ait		 — 	If AIT is running, opens AIT
mail		 — 	If outlook is running, opens outlook
word		 — 	If word is running, opens skype
excel		 — 	If excel is running, opens excel
skype		 — 	If skype is running, opens skype
snagit		 — 	If snagit is running, opens snagit
pmill		 — 	If PowerMILL is running, opens PMILL
pshape		 — 	If PowerSHAPE is running, opens PS
gmail		 — 	Opens gmail in your default browser
psteam		 — 	Opens psteam in internet explorer
baloo		 — 	Opens baloo in internet explorer
note		 — 	Opens notepad
pshelp		 — 	Opens the latest PowerSHAPE help
pmhelp		 — 	Opens the latest PowerMILL help
-		 — 	Inserts an em dash
calc		 —	Opens calculator
home		 — 	Shows the desktop
lock 		 — 	Locks computer and standby monitors
graph		 — 	Start graphing GUI
scanait		 — 	Starts AIT scannning GUI
pmillversions	 — 	List recent pmill versions
pmlocal		— 	Runs most recent pmill on pc
pmnet		— 	Runs latest pmill over network

        [Press space after command to activate]
-----------------------------------------------------------------------

dialog		 — 	Prints "The ... dialog is displayed"
g		 — 	Searches google for your term
b		 — 	Prints your term in bold (AIT)
spot		 — 	Search your term in Spotify
twitch		 — 	Search your term on Twitch.tv
delcam 		 — 	Go to \\Delcam\Doc\your term\
central 		 — 	Go to \\Delcam\central\transfer\
ns3 		 —	Go to \\NS3\ network location
exp 		 —  	Go to address in explorer
dir 		 —  	Go to address in explorer
pmillnet		 —  	Run version of pmill over network
		), 30
	}
	
return ; closes BarnesCommand.

;}

;-------------------------------------------------------
; GUI ESCAPES
;{------------------------------------------------------

resetGUI:
GuiControl,, SearchParam, ;clear the input box
Gui, Cancel ;hide the window
return

clearGUI:
GuiControl,, SearchParam ;clear the input box
return

; action of the escape key:
GuiEscape:
GuiControl,, SearchParam, ;clear the input box
Gui, Cancel
return

2GuiEscape:
GuiControl,, SearchEdit, ;clear the input box
Gui, Cancel
return

3GuiEscape:
GuiControl,, SearchEdit, ;clear the input box
Gui, Cancel
return

4GuiEscape:
GuiControl,, SearchEdit, ;clear the input box
Gui, Cancel
return

5GuiEscape:
Gui, Cancel
return


7GuiEscape:
XL.ActiveWorkbook.Close(0)
XL.Quit
xArrayCount = 0
yArrayCount = 0
Reload
return

8GuiEscape:
Reload
return

9GuiEscape:
Reload
return

10GuiEscape:
Reload
return

11GuiEscape:
Reload
return
;}

;-------------------------------------------------------
; COMMAND BOX LABELS
;{------------------------------------------------------

SearchEditEnter:
Gui, Submit
GuiControl,, SearchEdit, ;clear the input box
StringReplace, newSTRING, oldSTRING, REPLACEME, %SearchEdit%
Send, %newSTRING%
return

WebSearch:
Gui, Submit
if(SearchEdit = "Hearthstone")
{
	SearchEdit = Hearthstone: Heroes of Warcraft
	GuiControl,, SearchEdit, ;clear the input box
	StringReplace, newURL, oldURL, REPLACEME, %SearchEdit%
}
else if(SearchEdit = "lol")
{
	SearchEdit = League of Legends
	GuiControl,, SearchEdit, ;clear the input box
	StringReplace, newURL, oldURL, REPLACEME, %SearchEdit%
}
else
{
	GuiControl,, SearchEdit, ;clear the input box
	StringReplace, newURL, oldURL, REPLACEME, %SearchEdit%
}
Run %newURL%
return

Spotify:
Gui, Submit
GuiControl,, SearchEdit ;clear the input box
StringReplace, newSTRING, oldSTRING, REPLACEME, %SearchEdit%
WinShow ahk_class SpotifyMainWindow
WinActivate ahk_class SpotifyMainWindow
WinWait ahk_class SpotifyMainWindow
Send, ^l^+{Up}
Sleep, 100
Send, %newSTRING%
return

;}

;-------------------------------------------------------
; ADDITIONAL SCRIPTS
;{------------------------------------------------------
	;//////////////////////////////////////////////////////
	;Click in Websdl
	$^Enter::
	IfWinActive, SDL - Content Explorer - Google Chrome
	{
		Click
		return
	}
	else
	{
		Send, ^{Enter}
		return
	}
	
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;{ AIT Drag
	
	LAlt & WheelUp:: 
	IfWinActive, ahk_exe Authorit5.exe
	{
		Click down
		return
	}
	else
	{
		return
	}
	
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;{ AIT Embed
	
	LAlt & WheelDown:: 
	IfWinActive, ahk_exe Authorit5.exe
	{
		Sleep, 200
		Click
		Sleep, 200
		Send, {Down}{Down}{Enter}
		reload
		return
	}
	else
	{
		return
	}

	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;{ Excel shortcut
	
	!k::
	Send ^k{Tab 3}
	clipboard = 
	Send ^c
	ClipWait 
	StringSplit, id_array, clipboard, `#
	Send {Tab 9}
	Send http://help-staging.autodesk.com/view/FCAM/2019/ENU/?guid=%clipboard%
	Send {Enter}
	Return
	
	;}
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;{ Close AIT window
	
	$^t::
	IfWinActive, ahk_class WindowsForms10.Window.8.app.0.33c0d9d,, Author-it 5
	{
		Send !{Space}c
		Return
	}
	else IfWinActive, ahk_exe xmetal.exe
	{
		WinGetActiveTitle, Titleee
		Send, {F10}
		Sleep, 250
		Send, {s}
		Sleep, 250
		Send, {i}
		;ControlClick, x734 y116, %Titleee%
		;WinWaitActive, Close, Do you want to
		;Send, {Enter}
		WinWaitActive, Check in, Workflow, 10
		if ErrorLevel
		{
			MsgBox, WinWait timed out
			reload
		}
		else
		{
			Sleep, 100
			Send, {Enter}
			SoundBeep, 330, 120
		Return
		}
	}
	else
	{
		send, ^t
		return
	}
	
	; Hotkey to access import button for graphics in SDL
	$^i::
	IfWinActive, ahk_class WindowsForms10.Window.8.app.0.2383bf_r14_ad1
	{
		controlclick, x432 y85
		return
	}
	else IfWinActive, Select [barnesc]
	{
		controlclick, x432 y85
		return
	}
	else
	{
		send, ^i
		return
	}
	;}
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;Search GUID from notpad in SDL
	$^2::
	IfWinActive, ahk_exe notepad++.exe
	{
		clipboard =
		Send, ^c
		ClipWait
		guidvar = %clipboard%
		clipboard=
		Sleep, 100
		Send, {Up}{Down}
		Sleep, 100
		Send, {Shift}+{End}
		Sleep, 100
		Send, ^c
		ClipWait
		cidvar = %clipboard%
		WinActivate, ahk_exe Trisoft.PublicationManager.Host.exe, Search
		IfWinActive, ahk_exe Trisoft.PublicationManager.Host.exe, Search
		{
			WinGetActiveTitle, Repotitle
			ControlClick,WindowsForms10.BUTTON.app.0.13fa1bf_r14_ad13, %Repotitle%, Reset
			Sleep, 100
			ControlSend, WindowsForms10.COMBOBOX.app.0.13fa1bf_r14_ad13, {t}{enter}, %Repotitle%
			Sleep, 100
			ControlClick, Edit1, %Repotitle%
			Send, %guidvar%
			Sleep, 100
			ControlClick, WindowsForms10.BUTTON.app.0.13fa1bf_r14_ad11, %Repotitle%, Search
		}
		Return
	}
	IfWinActive, ahk_exe EXCEL.EXE
	{
		clipboard =
		Send, ^c
		ClipWait
		guidvar = %clipboard%
		clipboard =
		Sleep, 100
		WinActivate, ahk_exe Trisoft.PublicationManager.Host.exe, Search
		IfWinActive, ahk_exe Trisoft.PublicationManager.Host.exe, Search
		{
			WinGetActiveTitle, Repotitle
					ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad13, %Repotitle%, Reset
					Sleep, 200
					WinGetText, AdvOptsTextVar, %RepoTitle%,
					IfNotInString, AdvOptsTextVar, &Identifier
					{
					Send, {alt down}{d}{alt up}
					}
					Sleep, 200
					ControlClick, WindowsForms10.EDIT.app.0.2383bf_r14_ad112, %Repotitle%, Identifier
					Send, %guidvar%
					Sleep, 100
					ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad11, %Repotitle%, Search ; If this stops working, check that the name of the control hasn't changed.
					Loop
					{
						if (A_Cursor != "Arrow")
						{
							continue
						}
						if (A_Cursor = "Arrow")
						{
							soundbeep, 523, 50
							soundBeep, 523, 50
							soundBeep ,523, 50
							soundBeep, 523, 450
							soundBeep, 415, 350
							soundBeep, 466, 300
							soundBeep, 523, 150
							soundBeep, 466, 50
							soundBeep, 523, 900
							return
						}
					}
					return
			;WinGetActiveTitle, Repotitle
			;ControlClick,, %Repotitle%, Reset
			;Sleep, 100
			;;ControlClick, WindowsForms10.Window.8.app.0.2383bf_r14_ad159, %Repotitle%
			;Sleep, 100
			;ControlClick, Edit1, %Repotitle%
			;Send, %guidvar%
			;Sleep, 100
			;ControlClick, WindowsForms10.BUTTON.app.0.13fa1bf_r14_ad11, %Repotitle%, Search
			;Repotitle = 
		}
		Return
	}
		IfWinActive, PowerMill_Migration_Pass_1.xlsx - Google Chrome
	{
		clipboard =
		Send, ^c
		ClipWait
		guidvar = %clipboard%
		clipboard =
		Sleep, 100
		WinActivate, ahk_exe Trisoft.PublicationManager.Host.exe, Search
		IfWinActive, ahk_exe Trisoft.PublicationManager.Host.exe, Search
		{
			WinGetActiveTitle, Repotitle
			ControlClick,, %Repotitle%, Reset
			Sleep, 100
			;ControlClick, WindowsForms10.Window.8.app.0.2383bf_r14_ad159, %Repotitle%
			Sleep, 100
			ControlClick, Edit1, %Repotitle%
			Send, %guidvar%
			Sleep, 100
			ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad11, %Repotitle%, Search
			Repotitle = 
		}
		Return
	}
	IfWinActive, ahk_class Chrome_WidgetWin_1							; If Chrome browser is active run script
	{                                                           
		Send, {F6}													; Focus the address bar
		Send ^c						                          	    ; Copy the address line
		ChromeURL := clipboard
		StringSplit, URL_array, ChromeURL, `=                        ; Split the string before and after the =
		IfWinExist, Browse Repository
		{
			WinActivate, ahk_exe Trisoft.PublicationManager.Host.exe, Search
			IfWinActive, ahk_exe Trisoft.PublicationManager.Host.exe, Search
			{
				WinGetActiveTitle, Repotitle
				ControlClick,WindowsForms10.BUTTON.app.0.2383bf_r14_ad13, %Repotitle%, Reset
				Sleep, 200
				WinGetText, AdvOptsTextVar, %RepoTitle%,
				IfNotInString, AdvOptsTextVar, &Identifier
				{
				Send, {alt down}{d}{alt up}
				}
				Sleep, 200
				ControlClick, WindowsForms10.EDIT.app.0.2383bf_r14_ad112, %Repotitle%, Identifier
				Send, %URL_array2%
				Sleep, 100
				ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad11, %Repotitle%, Search
				Sleep, 300
				Loop
				{
					if (A_Cursor != "Arrow")
					{
						continue
					}
					if (A_Cursor = "Arrow")
					{
						soundbeep, 523, 50
						soundBeep, 523, 50
						soundBeep ,523, 50
						soundBeep, 523, 450
						soundBeep, 415, 350
						soundBeep, 466, 300
						soundBeep, 523, 150
						soundBeep, 466, 50
						soundBeep, 523, 900
						return
					}
				}
				return
			}
			return
		}
		else
		{
			WinActivate, ahk_exe Trisoft.PublicationManager.Host.exe
			Sleep, 100
			Send, {alt down}{t}{alt up}
			Sleep, 20
			ControlSend, WindowsForms10.Window.8.app.0.2383bf_r14_ad1142 , {f10}, Trisoft.PublicationManager.Host.exe
			Sleep, 100
			Send, {b}
			Sleep, 100
			WinWait, Browse Repository,, 5
				If ErrorLevel{
				Msgbox, Winwait timed out
				return
				}
			Send, ^{tab}
			Sleep, 500
			IfWinActive, ahk_exe Trisoft.PublicationManager.Host.exe, Search
			{
				WinGetActiveTitle, Repotitle
				ControlClick,WindowsForms10.BUTTON.app.0.2383bf_r14_ad13, %Repotitle%, Reset
				Sleep, 200
				WinGetText, AdvOptsTextVar, %RepoTitle%,
				IfNotInString, AdvOptsTextVar, &Identifier
				{
				Send, {alt down}{d}{alt up}
				}
				Sleep, 200
				ControlClick, WindowsForms10.EDIT.app.0.2383bf_r14_ad112, %Repotitle%, Identifier
				Send, %URL_array2%
				Sleep, 100
				ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad11, %Repotitle%, Search ; If this stops working, check that the name of the control hasn't changed.
				Loop
				{
					if (A_Cursor != "Arrow")
					{
						continue
					}
					if (A_Cursor = "Arrow")
					{
						soundbeep, 523, 50
						soundBeep, 523, 50
						soundBeep ,523, 50
						soundBeep, 523, 450
						soundBeep, 415, 350
						soundBeep, 466, 300
						soundBeep, 523, 150
						soundBeep, 466, 50
						soundBeep, 523, 900
						return
					}
				}
				return
			}
			else
			{
				msgbox Something went wrong
				return
			}
			return
		}
	}
	
	else IfWinActive, ahk_exe mspaint.exe
	{
		WinGetActiveTitle, painttitle
		StringSplit, GUIDVAR, painttitle, =
		StringSplit, FinalGUID, GUIDVAR2, =
		clipboard = %FinalGUID1%
		ToolTip, %FinalGUID1%,,,
			SetTimer, RemoveToolTip, 2000
		WinClose, %painttitle%
		return
	}
	else
	{
		send, ^2
		return
	}
	
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	$^3::
	Send, {F6}													; Focus the address bar
			Send ^c						                          	    ; Copy the address line
			ChromeURL := clipboard
			StringSplit, URL_array, ChromeURL, `=                        ; Split the string before and after the =
				WinActivate, ahk_exe Trisoft.PublicationManager.Host.exe
				Sleep, 100
					WinGetActiveTitle, Repotitle
					ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad13, %Repotitle%, Reset
					Sleep, 200
					WinGetText, AdvOptsTextVar, %RepoTitle%,
					IfNotInString, AdvOptsTextVar, &Identifier
					{
					Send, {alt down}{d}{alt up}
					}
					Sleep, 200
					ControlClick, WindowsForms10.EDIT.app.0.2383bf_r14_ad112, %Repotitle%, Identifier
					Send, %URL_array2%
					Sleep, 100
					ControlClick, WindowsForms10.BUTTON.app.0.2383bf_r14_ad11, %Repotitle%, Search ; If this stops working, check that the name of the control hasn't changed.
					Loop
					{
						if (A_Cursor != "Arrow")
						{
							continue
						}
						if (A_Cursor = "Arrow")
						{
							soundbeep, 523, 50
							soundBeep, 523, 50
							soundBeep ,523, 50
							soundBeep, 523, 450
							soundBeep, 415, 350
							soundBeep, 466, 300
							soundBeep, 523, 150
							soundBeep, 466, 50
							soundBeep, 523, 900
							return
						}
					}
					return
				return
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	;{ Open Graphic/Topic in AIT or copy GraphicName/TopicID to clipboard

	^1::
	Gui, 5:Show,, AIT tools
	Return
	
	chmdata:
	Gui, 5: Submit, NoHide
	if (RadioButton1 = 1)
	{
		GoSub, GraphicAIT
	}
	if (RadioButton1 = 2)
	{
		GoSub, TopicAIT
	}
	if (RadioButton1 = 3)
	{
		GoSub, NetworkAITSnag
	}
	if (RadioButton1 = 4)
	{
		GoSub, NetworkAIT
	}
	if (RadioButton1 = 5)
	{
		GoSub, GraphicCopy
	}
	if (RadioButton1 = 6)
	{
		GoSub, TopicCopy
	}
	if (RadioButton1 = 7)
	{
		GoSub, AIT2File
	}
	if (RadioButton1 = 8)
	{
		GoSub, Ribbonfindtopic
	}
	if (RadioButton1 = 9)
	{
		GoSub, Aliascopy
	}
	Return
	
	GraphicAIT:
	Gosub, 5GuiEscape
	Sleep, 50
	IfWinActive, ahk_class HH Parent								; If chm file is active then run the script
	{                                                           
		Send {Click right}{Up}{Enter}                               ; Open properties
		Sleep, 150                                                   
		ControlClick, x150 y230, ahk_class #32770                         ; Click the address line
		Send {Ctrl Down}a{Ctrl Up}^c{Esc}                           ; Copy the address line
		StringSplit, graphic_array, clipboard, `/                   ; Split the string before and after the /
		StringTrimRight, graphicname, graphic_array2, 4             ; Delete 4 characters of the string after the /
		clipboard = %graphicname%                                   ; Fill the clipboard with the new string
		
		if graphicname is not integer                               ; If the string is alpha numeric give error.
		{
			WinActivate, Author-it 5
			Send ^q
			ControlClick, Reset, Quick Search
			ControlClick, x50 y100, Quick Search
			Send ^v
			Send {Enter}
			graphic_array2 = 
			clipboard = 
			Return
		}
		else														; Else search for graphic
		{
			MsgBox, 64, Get graphic name, Please hover your cursor over a graphic., 5
			clipboard = 
			graphic_array2 = 
			Return
		}
	}
	else																; Else do nothing
	{
		Return
	}
	reload
	Return
	
	TopicAIT:
	Gosub, 5GuiEscape
	Sleep, 50
	IfWinActive, ahk_class HH Parent								; If chm file is active then run the script
	{                                                           
		Send {Click right}{Up}{Enter}                               ; Open properties
		Sleep, 150                                                   
		ControlClick, x150 y275, ahk_class #32770                         ; Click the address line
		Send {Ctrl Down}a{Ctrl Up}^c{Esc}                           ; Copy the address line
		StringSplit, id_array, clipboard, `/                        ; Split the string before and after the /
		StringTrimRight, idname, id_array2, 4                       ; Delete 4 characters of the string after the /
		IfInString, idname, _
		{
		StringSplit, UnderScore_array, idname, `_
		idnamefinal := UnderScore_array1
		clipboard = %idnamefinal%                                        ; Fill the clipboard with the new string		
		}
		else
		{
		idnamefinal := idname	
		clipboard = %idnamefinal%                                        ; Fill the clipboard with the new string
		}
		
		if idnamefinal is integer                                        ; If the string is integer, search and open.
		{
			IfWinExist, Quick Search
			{
			;WinActivate, Author-it 5
			;Send ^q
			ControlClick, Reset, Quick Search
			;ControlClick, x250 y100, Quick Search
			;Send ^v
			ControlSend, Edit1, %clipboard%, Quick Search
			ControlClick, Search, Quick Search
			;Send {Enter}
			Sleep, 500
			ControlClick, x400 y320, Quick Search
			ControlSend, WindowsForms10.Window.8.app.0.33c0d9d5, {Enter}, Quick Search
			;Send {Enter}
			id_array2 = 
			return
			}
			else
			{
			ControlSend, WindowsForms10.Window.8.app.0.33c0d9d48, {CtrlDown}q{CtrlUp}, Author-it 5
			WinWait, Quick Search
			ControlClick, Reset, Quick Search
			ControlSend, Edit1, %clipboard%, Quick Search
			ControlClick, Search, Quick Search
			Sleep, 500
			ControlClick, x400 y320, Quick Search
			ControlSend, WindowsForms10.Window.8.app.0.33c0d9d5, {Enter}, Quick Search
			id_array2 = 
			return
			}
			Return
		}
		else														; Else display error	
		{
			MsgBox, 64, Get topic ID, Please hover your cursor over some text or whitespace in the topic., 5
			id_array2 = 
			Return
		}
	}
	else															; Else do nothing
	{
		Return
	}
	reload
	Return
	
	NetworkAITSnag:
	CoordMode, Mouse, Relative
	Gosub, 5GuiEscape
	Sleep, 50
	IfWinActive, ahk_class CabinetWClass
	{
		Send {Click right}{Up}{Enter}
		Sleep, 150
		WinGetText, AllText, ahk_class #32770
		StringSplit, Pic_Array, AllText, `n
		StringTrimRight, PicName, Pic_Array3, 5             
		; clipboard = %PicName%                           
		Send {Esc}
		
		if PicName is not integer
		{
			WinActivate, Author-it 5
			Send ^q
			ControlClick, Reset, Quick Search
			ControlClick, x50 y100, Quick Search
			Send %PicName%
			Send {Enter}
			ControlClick, x373 y638, Quick Search
			Send, {Enter}
			Sleep, 500
			Click 467, 108
			Sleep, 150
			IfWinActive, ahk_exe snagiteditor.exe
				{
				Send, ^v
				Sleep, 500
				Send, ^s
				}
			else
			{
				Return
			}
			Pic_Array3 = 
			; clipboard = 
			Return
		}
	}
	else																; Else do nothing
	{
		Return
	}
	reload
	Return
	
	NetworkAIT:
	CoordMode, Mouse, Relative
	Gosub, 5GuiEscape
	Sleep, 50
	IfWinActive, ahk_class CabinetWClass
	{
		Send {Click right}{Up}{Enter}
		Sleep, 150
		WinGetText, AllText, ahk_class #32770
		StringSplit, Pic_Array, AllText, `n
		StringTrimRight, PicName, Pic_Array3, 5             
		; clipboard = %PicName%                           
		Send {Esc}
		
		if PicName is not integer
		{
			WinActivate, Author-it 5
			Send ^q
			ControlClick, Reset, Quick Search
			ControlClick, x50 y100, Quick Search
			Send %PicName%
			Send {Enter}
			ControlClick, x373 y638, Quick Search
			Pic_Array3 = 
			; clipboard = 
			Return
		}
	}
	else																; Else do nothing
	{
		Return
	}
	reload
	Return
	
	GraphicCopy:
	Gosub, 5GuiEscape
	Sleep, 50
	IfWinActive, ahk_class HH Parent								; If chm file is active then run the script
	{                                                           
		Send {Click right}{Up}{Enter}                               ; Open properties
		Sleep, 150                                                   
		ControlClick, x150 y230, ahk_class #32770                   ; Click the address line
		Send {Ctrl Down}a{Ctrl Up}^c{Esc}                           ; Copy the address line
		StringSplit, graphic_array, clipboard, `/                   ; Split the string before and after the /
		StringTrimRight, graphicname, graphic_array2, 4             ; Delete 4 characters of the string after the /
		clipboard = %graphicname%                                   ; Fill the clipboard with the new string
		
		if graphicname is not integer                               ; If the string is alpha numeric give error.
		{
			ToolTip, %graphicname%,,,
			SetTimer, RemoveToolTip, 2000
			graphic_array2 = 
			Return
		}
			
		else														; Else do nothing
		{
			MsgBox, 64, Get graphic name, Please hover your cursor over a graphic., 5
			graphic_array2 =
			clipboard = 
			Return
		}
	}
	else																; Else do nothing
	{
		Return
	}
	reload
	Return
	
	TopicCopy:
	gosub, 5GuiEscape
	sleep, 50
	IfWinActive, ahk_class HH Parent								; If chm file is active then run the script
	{                                                           
		Send {Click right}{Up}{Enter}                               ; Open properties
		Sleep, 150                                                   
		ControlClick, x150 y275, ahk_class #32770                         ; Click the address line
		Send {Ctrl Down}a{Ctrl Up}^c{Esc}                           ; Copy the address line
		StringSplit, id_array, clipboard, `/                        ; Split the string before and after the /
		StringTrimRight, idname, id_array2, 4                       ; Delete 4 characters of the string after the /
		clipboard = %idname%                                        ; Fill the clipboard with the new string
		
		if idname is not alpha                                      ; .
		{
			Tooltip, %idname%,,,
			SetTimer, RemoveToolTip, 2000
			id_array2 =
			Return
		}
		else														; Else display error	
		{
			MsgBox, 64, Get topic ID, Please hover your cursor over some text or whitespace in the topic., 5
			id_array2 = 
			clipboard = 
			Return
		}
	}
	else															; Else do nothing
	{
		Return
	}
	reload
	Return
	
	
AIT2File:
	Gosub, 5GuiEscape
	Sleep, 50
	CoordMode, Mouse, Relative
	IfWinActive, ahk_class WindowsForms10.Window.8.app.0.33c0d9d
	{
	Send {Enter}^a^c
	Sleep, 250
	ClipWait, 1
	Send {Esc}
	Sleep, 500
	IfWinExist, powermill
		{
		WinActivate, powermill
		Sleep, 500
		Send ^f
		Send "%Clipboard%"
		}
	else
		{
		Run, explore \\ns3.delcam.local\ait_v4\graphics\powermill
		Sleep, 500
		Send ^f
		Send "%Clipboard%"
		}
	}
		else															; Else do nothing
		{
		Return
		}
	reload
	Return
	
Ribbonfindtopic:
	Gosub, 5GuiEscape
	Sleep, 50
	IfWinActive, ahk_class HH Parent								; If chm file is active then run the script
	{                                                           
		Send {Click right}{Up}{Enter}                               ; Open properties
		Sleep, 150                                                   
		ControlClick, x150 y275, ahk_class #32770                         ; Click the address line
		Send {Ctrl Down}a{Ctrl Up}^c{Esc}                           ; Copy the address line
		StringSplit, id_array, clipboard, `/                        ; Split the string before and after the /
		StringTrimRight, idname, id_array2, 4                       ; Delete 4 characters of the string after the /
		clipboard = %idname%                                        ; Fill the clipboard with the new string
		
		if idname is integer                                        ; If the string is integer, search and open.
		{
			WinActivate, Author-it 5
			Send ^q
			ControlClick, Reset, Quick Search
			ControlClick, x250 y100, Quick Search
			Send ^v
			Send {Enter}
			Sleep, 100
			id_array2 = 
			Return
		}
		else														; Else display error	
		{
			MsgBox, 64, Get topic ID, Please hover your cursor over some text or whitespace in the topic., 5
			id_array2 = 
			Return
		}
	}
	else															; Else do nothing
	{
		Return
	}
	reload
	Return

	AliasCopy:
	gosub, 5GuiEscape
	sleep, 50
	IfWinActive, ahk_class HH Parent								; If chm file is active then run the script
	{                                                           
		Send {Click right}{Up}{Enter}                               ; Open properties
		Sleep, 150                                                   
		ControlClick, x150 y275, ahk_class #32770                   ; Click the address line
		Send {Ctrl Down}a{Ctrl Up}^c							; Copy the address line
		Sleep, 50
		StringSplit, id_array, clipboard, `/                        ; Split the string before and after the /
		StringTrimRight, idname, id_array2, 4                       ; Delete 4 characters of the string after the /
		ControlClick, x97 y75, ahk_class #32770                     ; Click the Name
		Send {Ctrl Down}a{Ctrl Up}^c{Esc}							; Copy the Name
		aliasname = %clipboard%
		clipboard = %idname%.htm `/`/ %aliasname%                      ; Fill the clipboard with the new string
		
		if idname is not alpha                                      ; .
		{
			Tooltip, %idname%.htm `/`/ %aliasname%,,,
			SetTimer, RemoveToolTip, 2000
			id_array2 =
			Return
		}
		else														; Else display error	
		{
			MsgBox, 64, Get topic ID, Please hover your cursor over some text or whitespace in the topic., 5
			id_array2 = 
			clipboard = 
			Return
		}
	}
	else															; Else do nothing
	{
		Return
	}
	reload
	Return
	
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;{ Generate graph
	
	graphscript:
	;Graphing script
	xArray := Object()
	xArrayCount := 0
	yArray := Object()
	yArrayCount := 0
	
	Gui, 8: Show,, Graph
	return
	
	SubmitValues:
	Gui, 8: Submit
	if (NoXvalues = NoYvalues)
		{
			Gui,7: Show, w500 h330, Graph
			XL := ComObjCreate("Excel.Application")
			;Xl.Visible := True
			XL.WorkBooks.Add
			XL.Range("$A:$B").Select
			Loop, %NoXvalues%
				{
					xArrayCount +=1
					yArrayCount +=1
					InputBox, xloopvar, X, Enter X value %xArrayCount%,,200,100,400
					xArray.Push(xloopvar)
					InputBox, yloopvar, Y, Enter associated Y value for X%xArrayCount%,,200,100,400
					yArray.Push(yloopvar)
					XL.Range("A"A_Index).Value := xArray[A_Index]
					XL.Range("B"A_Index).Value := yArray[A_Index]
					XL.Range("$A:$B").Select
					XL.ActiveSheet.Shapes.AddChart.Select
					XL.ActiveChart.ChartType := 73
					XL.ActiveChart.PlotArea.Select
					XL.ActiveChart.SetElement(207)
					XL.Worksheets("Sheet1").ChartObjects(1).Chart.PlotBy = xlColumns
					XL.ActiveChart.SetSourceData(XL.Sheets(1).Range("$A:$B"), ComObjMissing())
					XL.ActiveChart.Export("C:\Users\Public\pic1.bmp")
					GuiControl, 7:, MyPic, C:\Users\Public\pic1.bmp
					Gosub, RefreshPic
				}
	xArrayCount = 0
	yArrayCount = 0	
		}
	else
		{
			Loop, %NoXvalues%
				{
					xArrayCount +=1
					InputBox, xloopvar, X,Enter X value %xArrayCount%,,200,100,400
					xArray.Push(xloopvar)
				}
			Loop, %NoYvalues%
				{
					yArrayCount +=1
					InputBox, yloopvar, Y,Enter y value %yArrayCount%,,200,100,400
					yArray.Push(yloopvar)
				}
	Gui, 9: Show,, Graph
		}
	return
	
	Graphcreate:
	Gui, 9: cancel
	
	XL := ComObjCreate("Excel.Application")
	XL.WorkBooks.Add
	
	Loop, %xArrayCount%
		{
			XL.Range("A"A_Index).Value := xArray[A_Index]
		}
	Loop, %yArrayCount%
		{
			XL.Range("B"A_Index).Value := yArray[A_Index]
		}
	
	XL.Range("$A:$B").Select
	XL.ActiveSheet.Shapes.AddChart.Select
	XL.ActiveChart.ChartType := 73
	XL.ActiveChart.PlotArea.Select
	XL.ActiveChart.SetElement(207)
	XL.ActiveChart.SetSourceData(XL.Sheets(1).Range("A:B"), ComObjMissing())
	
	
	XL.Worksheets("Sheet1").ChartObjects(1).Chart.Export("C:\Users\Public\pic1.bmp")
	
	Gui,7: Show, w500 h330,Graph
	return
	
	RefreshPic:
	GuiControl, 7:, MyPic, C:\Users\Public\pic1.bmp
	return
	
	RealTime:
	Gui, 8: Submit
	Gui, 7: Show, w500 h330, Realtime Graph
	sinusoid = 1
			XL := ComObjCreate("Excel.Application")
			;Xl.Visible := True
			XL.WorkBooks.Add
			XL.Range("$A:$B").Select
			Loop,
				{
					if (BreakLoop = 1)
					{
						break
					}
					if(IncreasingX = 1)
					{
						xArray.Push(xArrayCount)
						xArrayCount +=1
						InputBox, yloopvar, Y%yArrayCount%, Enter associated Y value for X%xArrayCount%,,200,100,400
						yArray.Push(yloopvar)
						yArrayCount +=1
						XL.Range("A"A_Index).Value := xArray[A_Index]
						XL.Range("B"A_Index).Value := yArray[A_Index]
						XL.Range("$A:$B").Select
						XL.ActiveSheet.Shapes.AddChart.Select
						XL.ActiveChart.ChartType := 73
						XL.ActiveChart.PlotArea.Select
						XL.ActiveChart.SetElement(207)
						XL.Worksheets("Sheet1").ChartObjects(1).Chart.PlotBy = xlColumns
						XL.ActiveChart.SetSourceData(XL.Sheets(1).Range("$A:$B"), ComObjMissing())
						XL.ActiveChart.Export("C:\Users\Public\pic1.bmp")
						GuiControl, 7:, MyPic, C:\Users\Public\pic1.bmp
						Gosub, RefreshPic
					}
					if (RandY = 1)
					{
						Random, yloopvar, -50, 50
						xArray.Push(xArrayCount)
						xArrayCount +=1
						yArray.Push(yloopvar)
						XL.Range("A"A_Index).Value := xArray[A_Index]
						XL.Range("B"A_Index).Value := yArray[A_Index]
						XL.Range("$A:$B").Select
						XL.ActiveSheet.Shapes.AddChart.Select
						XL.ActiveChart.ChartType := 73
						XL.ActiveChart.PlotArea.Select
						;XL.ActiveChart.SetElement(207)
						XL.Worksheets("Sheet1").ChartObjects(1).Chart.PlotBy = xlColumns
						XL.ActiveChart.SetSourceData(XL.Sheets(1).Range("$A:$B"), ComObjMissing())
						XL.ActiveChart.Export("C:\Users\Public\pic1.bmp")
						GuiControl, 7:, MyPic, C:\Users\Public\pic1.bmp
						Gosub, RefreshPic
					}
					if (CosX = 1)
					{
						xArray.Push(xArrayCount)
						xArrayCount +=1
						yArray.Push(sinusoid)
						sinusoid := sinusoid * -1
						;sinusoid := 100/(100+xArrayCount)
						XL.Range("A"A_Index).Value := xArray[A_Index]
						XL.Range("B"A_Index).Value := yArray[A_Index]
						XL.Range("$A:$B").Select
						XL.ActiveSheet.Shapes.AddChart.Select
						XL.ActiveChart.ChartType := 73
						XL.ActiveChart.PlotArea.Select
						;XL.ActiveChart.SetElement(207)
						XL.Worksheets("Sheet1").ChartObjects(1).Chart.PlotBy = xlColumns
						XL.ActiveChart.SetSourceData(XL.Sheets(1).Range("$A:$B"), ComObjMissing())
						XL.ActiveChart.Export("C:\Users\Public\pic1.bmp")
						GuiControl, 7:, MyPic, C:\Users\Public\pic1.bmp
						Gosub, RefreshPic
					}
					if (XandY = 1)
					{
						InputBox, xloopvar, X%xArrayCount%, Enter X value %xArrayCount%,,200,100,400
						xArray.Push(xloopvar)
						xArrayCount +=1
						InputBox, yloopvar, Y%yArrayCount%, Enter associated Y value for X%xArrayCount%,,200,100,400
						yArray.Push(yloopvar)
						yArrayCount +=1
						XL.Range("A"A_Index).Value := xArray[A_Index]
						XL.Range("B"A_Index).Value := yArray[A_Index]
						XL.Range("$A:$B").Select
						XL.ActiveSheet.Shapes.AddChart.Select
						XL.ActiveChart.ChartType := 73
						XL.ActiveChart.PlotArea.Select
						XL.ActiveChart.SetElement(207)
						XL.Worksheets("Sheet1").ChartObjects(1).Chart.PlotBy = xlColumns
						XL.ActiveChart.SetSourceData(XL.Sheets(1).Range("$A:$B"), ComObjMissing())
						XL.ActiveChart.Export("C:\Users\Public\pic1.bmp")
						GuiControl, 7:, MyPic, C:\Users\Public\pic1.bmp
						Gosub, RefreshPic
					}
					;sleep, 250
				}
	xArrayCount = 0
	yArrayCount = 0	
	
	BrLoop:
	BreakLoop = 1
	Gosub, 7GuiEscape
	return
	
	PauseLoop:
	Pause, Toggle, 1
	return
	
	;}
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	;{ AIT relationships/filename scan
		
	output =
	output_array1 =
	loopcounter = 0
	
	
	AITScanButton:
	Gui, 10: Submit
	Loop, %AITscan%
		{
		if (BreakLoop = 1)
			{
			break
			}
		GuiControl, 11: +Range0-%AITscan%, MyTotalProgress
		GuiControl, 11:, MyProgress, 0
		GuiControl, 11:, PercentText, % (loopcounter/AITScan)*100 . "%"
		loopcounter +=1
		Gosub, Refreshloopnumber
		IfWinNotExist, Quick Search
				{
					GuiControl, 11:, ProgressText, Could not find Quick Search window.
					Sleep, 3000
					WinActivate, Author-it 5
					Send, ^q
					GuiControl, 11:, ProgressText, Re-opening Quick Search window.
					Sleep, 3000
				}
		WinActivate, Quick Search
		if(UsingScan = 1)
			{
			Send ^r
			Sleep, 250
			WinWait, Show Relationships
			WinActivate, Show Relationships
			DetectHiddenText, Off
			WinGetText, output, , Objects using
			GuiControl, 11:, MyProgress, 40
			StringSplit, output_array, output, `n
				if(output_array1 = "")
				{
					FileAppend, EMPTY`n, C:\Users\Public\[Using] Relationships scan.txt
				}
				else
				{
					FileAppend, %output_array1%`n, C:\Users\Public\[Using] Relationships scan.txt 
				}
			Send !{Space}c
			GuiControl, 11:, PercentText, % (loopcounter/AITScan)*100 . "%"
			GuiControl, 11:, MyProgress, 100
			Sleep, 250
			GuiControl, 11:, MyTotalProgress, +1
			Send {Down}
			output = 
			output_array1 =
			}
		if(UsedByScan = 1)
			{
			Send ^r
			Sleep, 250
			WinWait, Show Relationships
			WinActivate, Show Relationships
			DetectHiddenText, Off
			WinGetText, output,
			GuiControl, 11:, MyProgress, 40
			StringReplace, ReplaceOut, output, Objects used by , @
			StringSplit, ReplaceOutput_Array, ReplaceOut, @
			StringSplit, output_array, ReplaceOutput_Array2, `n
				if(output_array1 = "")
				{
					FileAppend, EMPTY`n, C:\Users\Public\[Used by] Relationships Scan.txt
				}
				else
				{
					FileAppend, Objects used by %output_array1%`n, C:\Users\Public\[Used by] Relationships Scan.txt
				}
			Send !{Space}c
			GuiControl, 11:, PercentText, % (loopcounter/AITScan)*100 . "%"
			GuiControl, 11:, MyProgress, 100
			GuiControl, 11:, MyTotalProgress, +1
			Sleep, 250
			Send {Down}
			output = 
			output_array1 =
			}
		if(NameScan = 1)
			{
			Send {Enter}^a^c
			GuiControl, 11:, MyProgress, 50
			ClipWait, 1
			if clipboard =
			{
				Send {Esc}
				FileAppend, ERROR`n, C:\Users\Public\Names Scan.txt
				Sleep, 500
				Send {Down}
			}
			else 
			{
				Send {Esc}
				FileAppend, %clipboard%`n, C:\Users\Public\Names Scan.txt
				Sleep, 500
				Send {Down}
				clipboard = 
			}
			GuiControl, 11:, PercentText, % (loopcounter/AITScan)*100 . "%"
			GuiControl, 11:, MyProgress, 100
			GuiControl, 11:, MyTotalProgress, +1
			}
		if(UsingOCRScan = 1)
			{
			CoordMode,Pixel,Screen
			clipboard =
			Send ^r
			Sleep, 250
			WinWait, Show Relationships
			WinActivate, Show Relationships
			WinGetText, nameoutput,
			StringReplace, nameoutputREPLACE, nameoutput, ToolStripNavigate, @
			StringSplit, nameoutputREPLACE_Array, nameoutputREPLACE, @
			StringReplace, nameoutputFINAL, nameoutputREPLACE_Array2, `r`n, , All
			Click, WheelDown, 4
			GuiControl, 11:, MyProgress, 20
			Sleep, 100
			ImageSearch, Xout, Yout, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusing.png
			If(ErrorLevel = 1)
				ImageSearch, Xout, Yout, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusing2.png
			NewX := Xout+420
			NewY := Yout+46
			GuiControl, 11:, MyProgress, 30
			Sleep, 150
			GuiControl, 11:, ProgressText, Running OCR.
			Run, C:\Users\Public\Capture2Text_v3.9\Capture2Text\Capture2Text.exe %NewX% %NewY% 568 1015 output.txt
			ClipWait, 3
			GuiControl, 11:, MyProgress, 40
			Sleep, 150
			ocroutput := clipboard
			StringReplace, ocroutput1FIX, ocroutput, Section Template - Contim, Section - Continuous Template, All
			StringReplace, ocroutput2FIX, ocroutput1FIX, Template%A_SPACE%, Template`,, All
			StringReplace, ocroutputFINAL, ocroutput2FIX, HTML Only%A_SPACE%, HTML Only`,, All
			Gosub, RefreshOCR
			FileAppend, %nameoutputFINAL%`t%ocroutputFINAL%`n, C:\Users\Public\[Using] OCR Template Scan.txt
			Send !{Space}c
			GuiControl, 11:, MyProgress, 80
			GuiControl, 11:, MyTotalProgress, +1
			GuiControl, 11:, PercentText, % (loopcounter/AITScan)*100 . "%"
			Sleep, 150
			Send {Down}
			output = 
			GuiControl, 11:, MyProgress, 100
			GuiControl, 11:, ProgressText, Cycle complete.
			Sleep, 100
			}
		if(UsedByOCRScan = 1)
			{
			CoordMode,Pixel,Screen
			clipboard =
			Send ^r
			Sleep, 250
			WinWait, Show Relationships
			WinActivate, Show Relationships
			WinGetText, nameoutput,
			StringReplace, nameoutputREPLACE, nameoutput, ToolStripNavigate, @
			StringSplit, nameoutputREPLACE_Array, nameoutputREPLACE, @
			StringReplace, nameoutputFINAL, nameoutputREPLACE_Array2, `r`n, , All
			GuiControl, 11:, MyProgress, 20
			Sleep, 100
			ImageSearch, X1out, Y1out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusedby.png
			If(ErrorLevel = 1)
				ImageSearch, X1out, Y1out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusedby2.png
				If(ErrorLevel = 1)
					ImageSearch, X1out, Y1out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusedby3.png
					If(ErrorLevel = 1)
						ImageSearch, X1out, Y1out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusedby4.png
						If(ErrorLevel = 1)
							ImageSearch, X1out, Y1out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusedby5.png
			ImageSearch, X2out, Y2out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\localizations.png
			If(ErrorLevel = 1)
				ImageSearch, X2out, Y2out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusing.png
				If(ErrorLevel = 1)
					ImageSearch, X2out, Y2out, 3, 90, 180, 1010, C:\Users\Public\Capture2Text_v3.9\Capture2Text\objectsusing2.png
			NewX := X1out+420
			NewY := Y1out+46
			GuiControl, 11:, MyProgress, 30
			Sleep, 150
			GuiControl, 11:, ProgressText, Running OCR.
			Run, C:\Users\Public\Capture2Text_v3.9\Capture2Text\Capture2Text.exe %NewX% %NewY% 568 %Y2out% output.txt
			ClipWait, 3
			GuiControl, 11:, MyProgress, 40
			Sleep, 150
			ocroutput := clipboard
			StringReplace, ocroutput1FIX, ocroutput, Section Template - Contim, Section - Continuous Template, All
			StringReplace, ocroutput2FIX, ocroutput1FIX, Template%A_SPACE%, Template`,, All
			StringReplace, ocroutputFINAL, ocroutput2FIX, HTML Only%A_SPACE%, HTML Only`,, All
			Gosub, RefreshOCR
			FileAppend, %nameoutputFINAL%`t%ocroutputFINAL%`n, C:\Users\Public\[Used By] EB-EB Scan.txt
			Send !{Space}c
			GuiControl, 11:, MyProgress, 80
			GuiControl, 11:, MyTotalProgress, +1
			GuiControl, 11:, PercentText, % (loopcounter/AITScan)*100 . "%"
			Sleep, 150
			Send {Down}
			output = 
			GuiControl, 11:, MyProgress, 100
			GuiControl, 11:, ProgressText, Cycle complete.
			Sleep, 100
			}
		}
	Gui, 11: Hide
	if(UsingScan = 1)
	{
	run, C:\Users\Public\[Using] Relationships scan.txt
	}
	if(UsedByScan = 1)
	{
	run, C:\Users\Public\[Used by] Relationships Scan.txt
	}
	if(NameScan = 1)
	{
	run, C:\Users\Public\Names Scan.txt .
	}
	if (UsingOCRScan = 1)
	{
	run, C:\Users\Public\[Using] OCR Template Scan.txt
	ocroutputFINAL = 
	}
	{
	run, C:\Users\Public\[Used By] EB-EB Scan.txt
	ocroutputFINAL =
	}
	sleep, 500
	MsgBox,,Scan complete, Scan completed after %loopcounter% cycles.
	loopcounter =
	reload
	Return
	
	Refreshloopnumber:
	GuiControl, 11:, MyText, %loopcounter%
	GuiControl, 11:, MyProgress, 10
	GuiControl, 11:, ProgressText, Checking for active window.
	return
	
	RefreshOCR:
	GuiControl, 11:, OCRText, %ocroutputFINAL%
	GuiControl, 11:, MyProgress, 60
	GuiControl, 11:, ProgressText, Appending text file.
	return
	
	ShowLoopGui:
	Gui, 11: Show, NoActivate X2100 Y50, Loop Counter
	return
	
	HideLoopGui:
	Gui, 11: Hide
	return
	
	RefreshLoopGui:
	GuiControl, 11:, MyProgress, 0
	GuiControl, 11:, MyTotalProgress, 0
	GuiControl, 11:, MyText, %loopcounter%
	GuiControl, 11:, OCRText, %ocroutputFINAL%
	GuiControl, 11:, ProgressText, Scan not started.
	return
	;}
	;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
	
	;}