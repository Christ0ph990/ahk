Excelify()
{
	global SelectedProduct
	global SelectedAYearLan
	global SelectedBYearLan
	global StagingOrProduction
XLpercentdone := 0
Progress, m1 h100 w300 0 `%, ,Exporting to excel `r`nPress Shift`+ Esc to cancel.
TextPath := A_ScriptDir "\AKN_Extract\output.txt"
XL := ComObjCreate("Excel.Application")
XL.WorkBooks.Add(TextPath)
XLwbook := ComObjGet(TextPath)
XL.Columns("A:A").Select
XL.Selection.TextToColumns(XL.Range("A:A"), 1, 1, 0, 1, 0, 0, 0, 1, "¬")
XL.Columns("A:E").Select
XL.Selection.EntireColumn.AutoFit
XL.Range("A1:E1").Select
XL.Selection.Interior.ColorIndex := 24
XL.Selection.Font.Bold := True
XL.Rows("2:2").Select
XL.ActiveWindow.FreezePanes := True
XL.Worksheets("output").Activate
LastRow := XL.ActiveSheet.UsedRange.Rows.Count + XL.ActiveSheet.UsedRange.Rows(1).Row -1
guidURL = http`:`/`/%StagingOrProduction%`.autodesk`.com`/view`/%SelectedProduct%`/%SelectedAYearLan%`/%SelectedBYearLan%`/`?guid`=
Loop % LastRow
{
	XL.Range("A"A_Index).Select
	If(XL.Selection.Value = "")
	{
		continue
	}
	else
	{
		XL.Worksheets("output").Hyperlinks.Add(Anchor:=XL.Worksheets("output").Cells(A_Index,1), Address:=(guidURL XL.Selection.Value))
	}
	XLpercentdone := (A_Index/LastRow)*100
	Progress, %XLpercentdone%, %XLpercentdone% `%,, %XLpercentdone% `%
}
Progress, Off


SavePath := A_ScriptDir "\AKN_Extract\exceloutput.xlsx"
XLwbook.SaveAs(SavePath, 51)
XL.Workbooks.Close
ObjRelease(XL)
ObjRelease(XLwbook)
}

ButtonLink()
{
	Gui, Add, Button, x220 y350 w100 h30 gnextGUI, Next
	hyperlink := "https://wiki.autodesk.com/display/DLCG/Extracting+Titles%2C+GUIDs%2C+and+CIDs+from+publications"
	Gui, Add, Link, x+-310 Y+0, <a href="%hyperlink%">Help</a>
}

duration(n){
	sec:=1, min:=60*sec, hr:=60*min, day:=24*hr, wk:=7*day
	w	:=n//wk		, n:=Mod(n,wk)
	d	:=n//day	, n:=Mod(n,day)
	h	:=n//hr		, n:=Mod(n,hr)
	m	:=n//min	, n:=Mod(n,min)
	s	:=n
	return trim((w?w " wk, ":"") (d?d " d, ":"") (h?h " hr, ":"") (m?m " min, ":"") (s?s " sec":""),", ")
}