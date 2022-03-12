Attribute VB_Name = "Module1"
Sub Open_txt_SNRFEC()
Attribute Open_txt_SNRFEC.VB_Description = "Opens text file to be used with SNR-FEC analysis"
Attribute Open_txt_SNRFEC.VB_ProcData.VB_Invoke_Func = "O\n14"
'
' Open_txt_SNRFEC Macro
' Opens text file to be used with SNR-FEC analysis
'
' Keyboard Shortcut: Ctrl+Shift+O
'
 FileToOpen = Application.GetOpenFilename("Text Files (*.txt),*.txt")
    If FileToOpen <> False Then
   Workbooks.OpenText FileToOpen, Origin:=437, _
        StartRow:=1, DataType:=xlDelimited, TextQualifier:=xlDoubleQuote, _
        ConsecutiveDelimiter:=False, Tab:=True, Semicolon:=False, Comma:=True, _
        Space:=False, Other:=False, FieldInfo:=Array(Array(1, 1), Array(2, 1), Array( _
        3, 1), Array(4, 1), Array(5, 1)), TrailingMinusNumbers:=True
    End If
End Sub
Sub Generates_SNRFEC_graphs()
Attribute Generates_SNRFEC_graphs.VB_Description = "Generates de SNR/FEC Charts"
Attribute Generates_SNRFEC_graphs.VB_ProcData.VB_Invoke_Func = "R\n14"
'
' Generates_SNRFEC_graphs Macro
' Generates de SNR/FEC Charts
'
' Keyboard Shortcut: Ctrl+Shift+R
'
    LR = Cells(Rows.Count, "B").End(xlUp).Row
    Columns("B:B").EntireColumn.AutoFit
    Columns("C:C").EntireColumn.AutoFit
    Rows("1:1").Select
    Selection.Insert Shift:=xlDown, CopyOrigin:=xlFormatFromLeftOrAbove
    Columns("D:D").Select
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Columns("F:F").Select
    Selection.Insert Shift:=xlToRight, CopyOrigin:=xlFormatFromLeftOrAbove
    Range("A1").Select
    ActiveCell.FormulaR1C1 = "Time"
    Range("D1").Select
    ActiveCell.FormulaR1C1 = "Corrected"
    Range("F1").Select
    ActiveCell.FormulaR1C1 = "Uncorrected"
    Range("H1").Select
    ActiveCell.FormulaR1C1 = "SNR"
    Range("H1").Select
    Columns("F:F").EntireColumn.AutoFit
    Range("D3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-1]-R[-1]C[-1]"
    Range("D3").Select
    Selection.AutoFill Destination:=Range("D3:D" & LR)
    Range("D3:D44").Select
    Range("F3").Select
    Application.CutCopyMode = False
    ActiveCell.FormulaR1C1 = "=RC[-1]-R[-1]C[-1]"
    Range("F3").Select
    Selection.AutoFill Destination:=Range("F3:F" & LR)
    Range("F3:F44").Select
    Range("H3").Select
    ActiveCell.FormulaR1C1 = "=RC[-1]/10"
    Range("H3").Select
    Selection.AutoFill Destination:=Range("H3:H" & LR)
    Range("H3:H44").Select
    Range("A:A,D:D,F:F").Select
    Range("F1").Activate
    ActiveSheet.Shapes.AddChart2(297, xlColumnStacked).Select
    ActiveChart.SetSourceData Source:=Range( _
        "$A:$A,$D:$D,$F:$F")
    ActiveSheet.Shapes("Chart 1").IncrementLeft 174.75
    ActiveSheet.Shapes("Chart 1").IncrementTop -47.25
    Application.Width = 1122
    Application.Height = 702.75
    Range("A:A,H:H").Select
    Range("H1").Activate
    ActiveSheet.Shapes.AddChart2(332, xlLineMarkers).Select
    ActiveChart.SetSourceData Source:=Range("$A:$A,$H:$H")
    ActiveSheet.Shapes("Chart 2").IncrementLeft 155.25
    ActiveSheet.Shapes("Chart 2").IncrementTop 114
    ActiveChart.Axes(xlValue).Select
    ActiveChart.Axes(xlValue).MinimumScale = 0
    Application.CommandBars("Format Object").Visible = False
    ActiveSheet.ChartObjects("Chart 1").Activate
    ActiveChart.ChartTitle.Select
    ActiveChart.ChartTitle.Text = "FEC"
    Selection.Format.TextFrame2.TextRange.Characters.Text = "FEC"
    With Selection.Format.TextFrame2.TextRange.Characters(1, 3).ParagraphFormat
        .TextDirection = msoTextDirectionLeftToRight
        .Alignment = msoAlignCenter
    End With
    With Selection.Format.TextFrame2.TextRange.Characters(1, 3).Font
        .BaselineOffset = 0
        .Bold = msoFalse
        .NameComplexScript = "+mn-cs"
        .NameFarEast = "+mn-ea"
        .Fill.Visible = msoTrue
        .Fill.ForeColor.RGB = RGB(89, 89, 89)
        .Fill.Transparency = 0
        .Fill.Solid
        .Size = 14
        .Italic = msoFalse
        .Kerning = 12
        .Name = "+mn-lt"
        .UnderlineStyle = msoNoUnderline
        .Spacing = 0
        .Strike = msoNoStrike
    End With
    Range("T14").Select
End Sub
