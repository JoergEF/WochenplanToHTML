Attribute VB_Name = "ExportToJSON"
' -> NICHT VERGESSEN: Verweis auf Microsoft Scripting Runtime hinzufügen.
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

For i = 2 To excelRange.Columns.Count
    If (Cells(3, i) = "") Then GoTo NextIteration 'leere Spalten ausfiltern
    Set jsonDictionary = New Scripting.Dictionary
    
    jsonDictionary.Add "Kurs", Cells(3, i)
    Set x = New Scripting.Dictionary 'fuer die Wochentage
    
    For j = 1 To 5
        Set y = New Scripting.Dictionary 'fuer vormittag/nachmittag
        
        For k = 0 To 1
            Set z = New Scripting.Dictionary 'fuer die Inhalte
            
            z.Add "Fach", Cells(4 + Offset, i)
            z.Add "Trainer", Cells(5 + Offset, i)
            z.Add "Raum", Cells(6 + Offset, i)
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
