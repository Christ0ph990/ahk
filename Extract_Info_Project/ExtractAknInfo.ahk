﻿;{+++++++Starting stuff +++++++++
;#Warn, All,Off
#Warn
#SingleInstance Force
SetTitleMatchMode, 2
#Include %A_ScriptDir%
#Include C:\Users\Barnesc\Desktop\Extract_Info_Project\funcs.ahk
SetFormat, Float, 0.1
;{ ------------------ Stupid Shit -------------------------
Loop, 27
{
	%A_Index%NewY = 60
}
;}
FileRemoveDir, %A_ScriptDir%\AKN_Extract\, 1
FileCreateDir, %A_ScriptDir%\AKN_Extract\

;FileInstall, C:\Users\Work\Desktop\Extract_Info_Project\curl.exe, %A_ScriptDir%\AKN_Extract\curl.exe, 1
;FileInstall, C:\Users\Work\Desktop\Extract_Info_Project\jq.exe, %A_ScriptDir%\AKN_Extract\jq.exe, 1

FileInstall, C:\Users\Barnesc\Desktop\Extract_Info_Project\curl.exe, %A_ScriptDir%\AKN_Extract\curl.exe, 1
FileInstall, C:\Users\Barnesc\Desktop\Extract_Info_Project\jq.exe, %A_ScriptDir%\AKN_Extract\jq.exe, 1
Progress, 0, Downloading product information., , Downloading
URLDownloadToFile, http://help-staging.autodesk.com/view/, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
Progress, 50, Downloading product information.
ProductCode := Object()
AYearLanCode := Object()
BYearLanCode := Object()
SelectedProduct :=
SelectedAYearLan :=
SelectedBYearLan :=
GuidhtmObj := Object()
GuidObj := Object()
TitleObj := Object()
CidObj := Object()
;}+++++++++++++++++++++++++++++

;{ ********* Grab product codes from staging area ***************
Loop, Read, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
{
	If InStr(A_LoopReadLine, "align")
	{
		If InStr(A_LoopReadLine, "folder.gif")
		{		
		StringSplit, AProdNameArray, A_LoopReadLine, `"
		ProdNameVar := RTrim(AProdNameArray8, "/")
		ProductCode.Insert(ProdNameVar)
		}
	}
}
;} ***************************************************************

;{++++++++++++ GUI1 +++++++++++++++++
;Gui, +Resize 
Gui, Add, Tab2, h400 x0 w550, Delcam shortcuts| 1-16 | 17-32 | 33-48 | 49-64 | 65-80 | 81-96 | 97-112 | 113-128 | 129-144 | 145-160 | 161-176 | 177-192 | 193-208 |
Gui, Add, Checkbox, R4 X+240 Y90 vCheckPWRM, PWRM
Gui, Add, Checkbox, R4 vCheckPWRS, PWRS
Gui, Add, Checkbox, R4 vCheckPWRI, PWRI
Gui, Add, Checkbox, R4 vCheckFCAM, FCAM
ButtonLink()

Gui, Tab, 2
Loop % ProductCode.length()
{	
	;{ +++++ Stuff to get delcam stuff working ++++++++++++
	ProductName := ProductCode[A_Index]
	StringReplace, ReplacedString, ProductName, `-,
	IfInString, ReplacedString, PWRM
	{
		PWRMIndex := A_Index
	}
	IfInString, ReplacedString, PWRS
	{
		PWRSIndex := A_Index
	}
	IfInString, ReplacedString, PWRI
	{
		PWRIIndex := A_Index
	}
	IfInString, ReplacedString, FCAM
	{
		FCAMIndex := A_Index
	}
	;} +++++++++++++++++++++++++++++++++++++++++++++++++++++
	If A_Index between 1 and 16
	{
		Gui, Tab, 2
		ButtonLink()
		If A_Index between 1 and 8
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%1NewY% vCheck%A_Index%, %ProdCodeVar%
			1NewY += 35
			continue
		}
		If A_Index between 9 and 16
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%2NewY% vCheck%A_Index%, %ProdCodeVar%
			2NewY += 35
			continue
		}
	}
	If A_Index between 17 and 32
	{
		Gui, Tab, 3
		ButtonLink()
		If A_Index between 17 and 24
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%3NewY% vCheck%A_Index%, %ProdCodeVar%
			3NewY += 35
			continue
		}
		If A_Index between 25 and 32
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%4NewY% vCheck%A_Index%, %ProdCodeVar%
			4NewY += 35
			continue
		}
	}
	If A_Index between 33 and 48
	{
		Gui, Tab, 4
		ButtonLink()
		If A_Index between 33 and 40
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%5NewY% vCheck%A_Index%, %ProdCodeVar%
			5NewY += 35
			continue
		}
		If A_Index between 41 and 48
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%6NewY% vCheck%A_Index%, %ProdCodeVar%
			6NewY += 35
			continue
		}
	}
	If A_Index between 49 and 64
	{
		Gui, Tab, 5
		ButtonLink()
		If A_Index between 49 and 56
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%7NewY% vCheck%A_Index%, %ProdCodeVar%
			7NewY += 35
			continue
		}
		If A_Index between 57 and 64
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%8NewY% vCheck%A_Index%, %ProdCodeVar%
			8NewY += 35
			continue
		}
	}
	If A_Index between 65 and 80
	{
		Gui, Tab, 6
		ButtonLink()
		If A_Index between 65 and 72
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%9NewY% vCheck%A_Index%, %ProdCodeVar%
			9NewY += 35
			continue
		}
		If A_Index between 73 and 80
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%10NewY% vCheck%A_Index%, %ProdCodeVar%
			10NewY += 35
			continue
		}
	}
	If A_Index between 81 and 96
	{
		Gui, Tab, 7
		ButtonLink()
		If A_Index between 81 and 88
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%11NewY% vCheck%A_Index%, %ProdCodeVar%
			11NewY += 35
			continue
		}
		If A_Index between 89 and 96
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%12NewY% vCheck%A_Index%, %ProdCodeVar%
			12NewY += 35
			continue
		}
	}
	If A_Index between 97 and 112
	{
		Gui, Tab, 8
		ButtonLink()
		If A_Index between 97 and 104
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%13NewY% vCheck%A_Index%, %ProdCodeVar%
			13NewY += 35
			continue
		}
		If A_Index between 105 and 112
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%14NewY% vCheck%A_Index%, %ProdCodeVar%
			14NewY += 35
			continue
		}
	}
	If A_Index between 113 and 128
	{
		Gui, Tab, 9
		ButtonLink()
		If A_Index between 113 and 120
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%15NewY% vCheck%A_Index%, %ProdCodeVar%
			15NewY += 35
			continue
		}
		If A_Index between 121 and 128
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%16NewY% vCheck%A_Index%, %ProdCodeVar%
			16NewY += 35
			continue
		}
	}
	If A_Index between 129 and 144
	{
		Gui, Tab, 10
		ButtonLink()
		If A_Index between 129 and 136
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%17NewY% vCheck%A_Index%, %ProdCodeVar%
			17NewY += 35
			continue
		}
		If A_Index between 137 and 144
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%18NewY% vCheck%A_Index%, %ProdCodeVar%
			18NewY += 35
			continue
		}
	}
	If A_Index between 145 and 160
	{
		Gui, Tab, 11
		ButtonLink()
		If A_Index between 145 and 152
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%19NewY% vCheck%A_Index%, %ProdCodeVar%
			19NewY += 35
			continue
		}
		If A_Index between 153 and 160
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%20NewY% vCheck%A_Index%, %ProdCodeVar%
			20NewY += 35
			continue
		}
	}
	If A_Index between 161 and 176
	{
		Gui, Tab, 12
		ButtonLink()
		If A_Index between 161 and 168
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%21NewY% vCheck%A_Index%, %ProdCodeVar%
			21NewY += 35
			continue
		}
		If A_Index between 169 and 176
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%22NewY% vCheck%A_Index%, %ProdCodeVar%
			22NewY += 35
			continue
		}
	}
	If A_Index between 177 and 192
	{
		Gui, Tab, 13
		ButtonLink()
		If A_Index between 177 and 184
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%23NewY% vCheck%A_Index%, %ProdCodeVar%
			23NewY += 35
			continue
		}
		If A_Index between 185 and 192
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%24NewY% vCheck%A_Index%, %ProdCodeVar%
			24NewY += 35
			continue
		}
	}
	If A_Index between 193 and 208
	{
		Gui, Tab, 14
		ButtonLink()
		If A_Index between 193 and 200
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox, w150 h40 x110 Y%25NewY% vCheck%A_Index%, %ProdCodeVar%
			25NewY += 35
			continue
		}
		If A_Index between 201 and 208
		{
			ProdCodeVar := ProductCode[A_Index]
			Gui, Add, Checkbox,w150 h40 X340 Y%26NewY% vCheck%A_Index%, %ProdCodeVar%
			26NewY += 35
			continue
		}
	}
}
Progress, 100, Downloading product information.
Sleep, 1000
Progress, Off
Gui, Show, h400 w550, Choose a product code
return

GuiClose:
ExitApp

GuiEscape:
ExitApp
;}++++++++++++++++++++++++++++++++++++

nextGUI:
Gui, submit

;{ ++++++++++++ Connect Delcam page to all other stuff +++++++++++++
If(CheckPWRM = 1)
{
	Check%PWRMIndex% = 1
}
If(CheckPWRS = 1)
{
	Check%PWRSIndex% = 1
}
If(CheckPWRI = 1)
{
	Check%PWRIIndex% = 1
}
If(CheckFCAM = 1)
{
	Check%FCAMIndex% = 1
}
;} ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Loop % ProductCode.length()
{
	CheckNumber = Check%A_Index%
	If(%CheckNumber% = 1)
	{
		ProdCodeVar := ProductCode[A_Index]
		URLDownloadToFile, http://help-staging.autodesk.com/view/%ProdCodeVar%/, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
		SelectedProduct := ProdCodeVar
	}
}

;{ ********* Grab 1st year or language code from staging area ***************
Loop, Read, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
{
	If InStr(A_LoopReadLine, "align")
	{
		If InStr(A_LoopReadLine, "folder.gif")
		{		
		StringSplit, AAYearLanArray, A_LoopReadLine, `"
		AYearLanVar := RTrim(AAYearLanArray8, "/")
		AYearLanCode.Insert(AYearLanVar)
		}
	}
}
;} ***************************************************************

;{++++++++++++ GUI AYearLan +++++++++++++++++
Gui, AYearLan: +resize
Loop % AYearLanCode.length()
{
	AYearLanVar := AYearLanCode[A_Index]
	Gui, AYearLan: Add, Radio, R4 vAYLCheck%A_Index%, %AYearLanVar%
}
Gui, AYearLan: Add, Button, h30 w70 gnextGUI2, Next
Gui, AYearLan: Show, w350, Choose a year or language
return

AYearLanGuiClose:
ExitApp

AYearLanGuiEscape:
ExitApp
;}++++++++++++++++++++++++++++++++++++

nextGUI2:
Gui, AYearLan: Submit

Loop % AYearLanCode.length()
{
	AYLCheckNumber = AYLCheck%A_Index%
	If(%AYLCheckNumber% = 1)
	{
		AYearLanVar := AYearLanCode[A_Index]
		URLDownloadToFile, http://help-staging.autodesk.com/view/%SelectedProduct%/%AYearLanVar%/, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
		SelectedAYearLan := AYearLanVar
	}
}

;{ ********* Grab 2st year or language code from staging area ***************
Loop, Read, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
{
	If InStr(A_LoopReadLine, "align")
	{
		If InStr(A_LoopReadLine, "folder.gif")
		{		
		StringSplit, ABYearLanArray, A_LoopReadLine, `"
		BYearLanVar := RTrim(ABYearLanArray8, "/")
		BYearLanCode.Insert(BYearLanVar)
		}
	}
}
;} ***************************************************************

;{++++++++++++ GUI BYearLan +++++++++++++++++
Gui, BYearLan: +resize
Loop % BYearLanCode.length()
{
	BYearLanVar := BYearLanCode[A_Index]
	Gui, BYearLan: Add, Radio, R4 vBYLCheck%A_Index%, %BYearLanVar%
}
Gui, BYearLan: Add, Button, h30 w70 gnextGUI3, Next
Gui, BYearLan: Show, w350, Choose a year or language
return

BYearLanGuiClose:
ExitApp

BYearLanGuiEscape:
ExitApp
;}++++++++++++++++++++++++++++++++++++

nextGUI3:
Gui, BYearLan: Submit

Loop % BYearLanCode.length()
{
	BYLCheckNumber = BYLCheck%A_Index%
	If(%BYLCheckNumber% = 1)
	{
		BYearLanVar := BYearLanCode[A_Index]
		SelectedBYearLan := BYearLanVar
	}
}

;{++++++++++++ GUI Staging or Production +++++++++++++++++
Gui, ProdStag: +resize
Gui, ProdStag: Add, Radio, R4 vCheckProdStag, Production
Gui, ProdStag: Add, Radio, R4, Staging
Gui, ProdStag: Add, Button, h30 w70 gCIDbit, OK
Gui, ProdStag: Show, w350, Choose an environment
return

ProdStagGuiClose:
ExitApp

ProdStagGuiEscape:
ExitApp
;}++++++++++++++++++++++++++++++++++++

CIDbit:
Gui, ProdStag: Submit
if (CheckProdStag = 1)
{
	StagingOrProduction = help
	StagingVar = Production
}
if (CheckProdStag = 2)
{
	StagingOrProduction = help-staging
	StagingVar = Staging
}
Progress, 0, Downloading ToC, ,Downloading
LongAssString = %A_ScriptDir%\Akn_extract\curl.exe http://%StagingOrProduction%.autodesk.com/view/%SelectedProduct%/%SelectedAYearLan%/%SelectedBYearLan%/data/toctree.json | %A_ScriptDir%\Akn_extract\jq.exe . > %A_ScriptDir%\AKN_Extract\ParsedJSON.txt
Loop, 100
{
	Progress, %A_Index%, Downloading ToC
}
RunWait, %ComSpec% /c %LongAssString%, , Hide
Progress, 100, Done
Loop, Read, %A_ScriptDir%\AKN_Extract\ParsedJSON.txt
{
	IfInString, A_LoopReadLine, `"ln`"
	{
		;IfInString, A_LoopReadLine, GUID
		;{
			StringSplit, 1GuidArray, A_LoopReadLine, `"
			If(1GuidArray4 = "")
			{
			continue
			}
			GuidhtmObj.Insert(1GuidArray4)
		;}
	}
}
Progress, Off
FileAppend, GUID¬Title¬ContextID`r`n, %A_ScriptDir%\AKN_Extract\output.txt
ProgressCount :=
EstimateTime :=
FinalGuid :=
FinalTitle :=
FinalCid :=
IncTime :=
PercentDone :=
Loop % GuidhtmObj.length()
{
	ProgressCount += 1
}
StartTime := A_TickCount
Progress, m1 h350 w550 0 `%, ,%SelectedProduct% `- %SelectedAYearLan% `-` %SelectedBYearLan% `-` %StagingVar% `r`nPress Shift`+ Esc to cancel.
Loop % GuidhtmObj.length()
{
	LoopStartTime := A_TickCount
	GuidhtmVar := GuidhtmObj[A_Index]
	PercentDone := (A_Index/ProgressCount)*100
	URLDownloadToFile, http://%StagingOrProduction%.autodesk.com%GuidhtmVar%, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
	Loop, Read, %A_ScriptDir%\AKN_Extract\WorkingFile.txt
	{
		IfInString, A_LoopReadLine, `"topicid`"
		{
			StringSplit, 2GuidArray, A_LoopReadLine, "`
			FinalGuid := 2GuidArray4		
		}
		IfInString, A_LoopReadLine, `<title`>
		{
			StringSplit, TitleArray, A_LoopReadLine, `>
			StringTrimRight, TrimmedTitle, TitleArray2, 7
			StringReplace, 1ReplacedTitle, TrimmedTitle, Â, , All
			StringReplace, 2ReplacedTitle, 1ReplacedTitle, `&gt`;, `>, All
			StringReplace, 3ReplacedTitle, 2ReplacedTitle, `&amp`;, `&, All
			;StringReplace. 4ReplacedTitle, 3ReplacedTitle, `â`€`”, `-, All
			StringReplace, FinalTitle, 3ReplacedTitle, `&lt`;, `<, All
			FinalTitle := FinalTitle
		}
		IfInString, A_LoopReadLine, `"contextid`"
		{
			StringSplit, CidArray, A_LoopReadLine, "`
			CidObj.insert(CidArray4)
		}
	}	
	Progress, %PercentDone%, %PercentDone% `%`r`nTime Remaining: %EstimateTime%`r`n------------------------------------------------------------------------------------------------------------------------------------------`r`nGUID`:`r`n%FinalGuid%`r`n`r`nTitle`:`r`n%FinalTitle%`r`n`r`nContextId`:`r`n[%FinalCid%`],, %PercentDone% `%
	FileAppend, %FinalGuid%¬%FinalTitle%¬`r`n, %A_ScriptDir%\AKN_Extract\output.txt
	FinalCid :=
	Loop % CidObj.length()
	{
		FinalCid := CidObj[A_Index]
		FileAppend, ¬¬%FinalCid%`r`n, %A_ScriptDir%\AKN_Extract\output.txt
		Progress, %PercentDone%, %PercentDone% `%`r`nTime Remaining: %EstimateTime%`r`n------------------------------------------------------------------------------------------------------------------------------------------`r`nGUID`:`r`n%FinalGuid%`r`n`r`nTitle`:`r`n%FinalTitle%`r`n`r`nContextId`:`r`n[%FinalCid%`],, %PercentDone% `%
	}
	CidObj := ""
	CidObj := Object()
	LoopEndTime := A_TickCount
	LoopTime := (LoopEndTime-LoopStartTime)/1000
	IncTime += LoopTime
	AverageLoopTime := (IncTime/A_Index)
	TimeLeft := (AverageLoopTime*ProgressCount) - (AverageLoopTime*A_Index)
	EstimateTime := duration(TimeLeft)
}
TimeTaken := (A_TickCount - StartTime)/1000
TotalTime := duration(TimeTaken)
Progress, 100, Done
Sleep, 500
Excelify()
Progress, Off
MsgBox, 4, Complete ,Report finished in %TotalTime%.`n`n Would you like to display the results in excel.
IfMsgBox, Yes
{
Run, AKN_Extract\exceloutput.xlsx
ExitApp
}
IfMsgBox, No
{
ExitApp
}

+esc::
ExitApp