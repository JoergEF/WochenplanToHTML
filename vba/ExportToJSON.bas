Attribute VB_Name = "ExportToJSON"
Sub ExcelToJsonFile()

Dim excelRange As Range
Dim jsonItems As New Collection
Dim jsonDictionary As Scripting.Dictionary
Dim jsonFileExport As TextStream
Dim jsonFileObject As New FileSystemObject
Dim Wochentag(7) As String
Dim Tageszeit(2) As String
Dim x, y, z As Scripting.Dictionary
Dim i, j, k, Offset As Integer

'Variablen
Wochentag(0) = "Sonntag"
Wochentag(1) = "Montag"
Wochentag(2) = "Dienstag"
Wochentag(3) = "Mittwoch"
Wochentag(4) = "Donnerstag"
Wochentag(5) = "Freitag"
Wochentag(6) = "Samstag"
Tageszeit(0) = "vormittags"
Tageszeit(1) = "nachmittags"
Offset = 0

Set excelRange = Selection

For i = 1 To excelRange.Columns.Count
    If (excelRange.Columns.Cells(1, i) = "") Then GoTo NextIteration
    Set jsonDictionary = New Scripting.Dictionary
    
    jsonDictionary.Add "Kurs", excelRange.Columns.Cells(1, i)
    Set x = New Scripting.Dictionary 'für die Wochentage
    
    For j = 1 To 5
        Set y = New Scripting.Dictionary 'für vormittag/nachmittag
        
        For k = 0 To 1
            Set z = New Scripting.Dictionary 'Inhalte
            
            z.Add "Fach", excelRange.Columns.Cells(2 + Offset, i)
            z.Add "Trainer", excelRange.Columns.Cells(3 + Offset, i)
            z.Add "Raum", excelRange.Columns.Cells(4 + Offset, i)
            Offset = Offset + 3
            y.Add Tageszeit(k), z
            Set z = Nothing
        Next k
        
        Offset = Offset + 4
        x.Add Wochentag(j), y
        Set y = Nothing
    Next j
    
    Offset = 0
    jsonDictionary.Add "Inhalte", x
    Set x = Nothing
    jsonItems.Add jsonDictionary
    Set jsonDictionary = Nothing
NextIteration:
Next i

Set jsonFileExport = jsonFileObject.CreateTextFile("jsonExample.json", True)
jsonFileExport.WriteLine (JsonConverter.ConvertToJson(jsonItems, Whitespace:=3))

End Sub

